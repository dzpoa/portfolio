<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Home extends CI_Controller {

	function __construct()
	{	
		parent::__construct();
	}
	
	public function index()
	{
		//CSRF protection (Cross-Site Request Forgeries). im not using CI CSRF built in
		$this->session->set_userdata('token', md5(uniqid(rand(), TRUE)));
	
		$clients = array();
	
		$client = new Client();
		$client->distinct();
		$client->order_by("name", "asc");
		$client->get();
	
		foreach ($client as $c)
		{
			$projects = array();
			$c->project->get();
		
			foreach($c->project as $p)
			{
				$techs = array();
				$p->technology->get();
		
				foreach($p->technology as $t)
				{
					$t->category->get();
		
					$techs[] = array("id" => $t->id, "name" => $t->name, "category_id" => $t->category->id, "category_name" => $t->category->name);
				}
		
				$projects[] = array("name" => ($p->name=="" ? "(no specific name)" : $p->name), "year" => $p->year, "description" => $p->description, "technologies" => $techs);
			}
		
			$c->firm->get();
			$clients[] = array(
							"id" => $c->id,
							"name" => $c->name,
							"url" => anchor($c->url, $c->name, "target='blank'"),
							"firm" => anchor($c->firm->url, $c->firm->name, "target='blank'") . " ({$c->firm->branch})",
							"projects" => $projects
			);
		}
		$data['clients'] = $clients;
		
		$about = new About();
		$about->get();
		$data['about_me'] = $about->me;
		$data['about_site'] = $about->site;
		
		$tool = new Tool();
		$tool->get();
		
		$tools = array();
		foreach($tool as $t)
		{
			$tools[] = $t->description;
		}
		$data['tools'] = $tools;
		
		$vals = array(
					'img_path' => './captcha/',
					'img_url' => base_url() . "captcha/",
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
		
		$data["captcha"] = $captcha['image'];
		
		$data['token'] = $this->session->userdata('token');
		
		$this->smarty->view('home.tpl', $data);
	}
}