<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Ajax extends CI_Controller {

	function __construct() {
		
        parent::__construct();
    }

	function index()
	{
	}
	
	function technology()
	{
		$technology = new Technology();
		$technology->include_related_count('project')->get_by_id($this->input->post('id'));
		$count = $technology->project_count;
		
		$project = new Project();
		
		$percent = ( ($count * 100) / $project->count() );
		$percent = number_format($percent, 2);
		
		echo "{$technology->name} was used in a total of {$count} projects ({$percent}%)";
	}
	
	function category()
	{
		$category = new Category();
		$category->get_by_id($this->input->post('id'));
		
		$projects = array();
		
		$category->technology->get();
		$count = $category->technology->project->count();
		
		$project = new Project();
		
		$percent = ( ($count * 100) / $project->count() );
		$percent = number_format($percent, 2);
		
		echo "{$category->name} was used in a total of {$count} projects ({$percent}%)";
	}
	
	function firm()
	{
		//we don't need that
	}
	
	function year()
	{
		$project = new Project();
		
		$count = $project->where('year', $this->input->post('id'))->count();
		
		$project = new Project();
		
		$percent = ( ($count * 100) / $project->count() );
		$percent = number_format($percent, 2);
		
		echo "in {$this->input->post("id")} there was a total of {$count} projects ({$percent}%)";
	}
	
	function captcha()
	{
		$vals = array(
			'img_path' => './captcha/',
			'img_url' => base_url() . 'captcha/',
			'expiration' => 7200
		);	
		$captcha = create_captcha($vals);
		
		$istring = array(
			'captcha_time' => $captcha['time'],
			'ip_address' => $this->input->ip_address(),
			'word' => $captcha['word']
		);
		$sql = $this->db->insert_string('captcha', $istring);
		$this->db->query($sql);
		
		echo $captcha['image'];
	}
	
	function contact()
	{
		$this->load->library('form_validation');
		
		// First, delete old captchas
		$expiration = time() - $this->config->item('sess_expiration');
		$sql = "
				DELETE
				FROM
					captcha
				WHERE
					captcha_time < {$expiration}
		";
		$this->db->query($sql);
		
		// Then see if a captcha exists:
		$sql = "
				SELECT
					COUNT(*) AS count
				FROM
					captcha
				WHERE
					word = ?
					AND ip_address = ?
					AND captcha_time > ?
		";
		$binds = array($this->input->post("captcha"), $this->input->ip_address(), $expiration);
		$query = $this->db->query($sql, $binds);
		$row = $query->row();
		
		$return = array('error' => 0, 'feedback' => ':(');
		
		if ($row->count == 0)
		{
			$return = array('error' => 1, 'feedback' => 'Incorrect characters, type again please.');
		}
		elseif ($this->input->post('token') != $this->session->userdata('token'))
		{
			$return = array('error' => 1, 'feedback' => 'Incorrect token. CSRF is not allowed here :P');
		}
		else
		{
			postFilter();
			
			$this->form_validation->set_rules('name', '', 'trim|required|min_length[3]|max_length[250]');
			$this->form_validation->set_rules('email', '', 'trim|required|valid_email|min_length[5]|max_length[250]');
			$this->form_validation->set_rules('company', '', 'trim|min_length[3]|max_length[250]');
			$this->form_validation->set_rules('message', '', 'required|min_length[15]|max_length[5000]');
	
			if ($this->form_validation->run() == FALSE)
			{
				$return = array('error' => 1, 'feedback' => 'Enable Javascript Please.');
			}
			else
			{
				$sql = "
						INSERT
						INTO
							contact
						SET
							name = ?,
							email = ?,
							company = ?,
							message = ?,
							date = now()
				";
				$binds = array($this->input->post('name'), $this->input->post('email'), $this->input->post('company'), $this->input->post('message'));
				$this->db->query($sql, $binds);
				
				$this->load->library('email');
				
				$config['mailtype'] = 'html';
				$this->email->initialize($config);
				
				$this->email->from($this->config->item('admin_email'), 'dz.com');
				$this->email->to($this->config->item('admin_email'));
				
				$this->email->subject("New Message ({$this->input->post('email')})");
				$message = "
							Name: {$this->input->post('name')}<br/>
							Email: {$this->input->post('email')}<br/>
							Company: {$this->input->post('company')}<br/>
							Message: {$this->input->post('message')}<br/>
							Date: " . date('Y-m-d H:m:i') . "
				";
				$this->email->message($message);
				
				if (!$this->email->send())
				{
					$return = array('error' => 1, 'feedback' => 'An error occured while sending your email. Try again later please.');
				}
				else
				{
					$return = array('error' => 0, 'feedback' => 'Your contact was sent successfully, and should be replied shortly! Really thanks!');
				}
			}
		}
		
		echo json_encode($return);
	}
}
