<?php
class MY_Log extends CI_Log {
	
    public function __construct()
    {
        parent::__construct();
    }
    
    function write_log($level = 'error', $msg, $php_error = FALSE)
	{		
		if ($this->_enabled === FALSE)
		{
			return FALSE;
		}
		
		$level = strtoupper($level);
		
		if ( ! isset($this->_levels[$level]) OR ($this->_levels[$level] > $this->_threshold))
		{
			return FALSE;
		}
		
		$filepath = $this->_log_path.'log-'.date('Ymd-H').EXT;
		$message  = '';
		
		if ( ! file_exists($filepath))
		{
			$message .= "<"."?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed'); ?".">\n\n";
		}
			
		if (strpos($msg, "Could not find the language line")===FALSE) //CI bug, nervermind
		{
			if ( ! $fp = @fopen($filepath, FOPEN_WRITE_CREATE))
			{
				return FALSE;
			}
			
			$message .= date($this->_date_fmt). ' --> ' . $_SERVER['REQUEST_URI'] . ' --> '.$msg."\n";
			
			flock($fp, LOCK_EX);	
			fwrite($fp, $message);
			flock($fp, LOCK_UN);
			fclose($fp);
			
			/*
			$CI = & get_instance();
			
			$CI->load->helper('email');
			
			if (valid_email($CI->config->item('log_email')))
			{
			    $CI->load->library('email');
			    $CI->email->from($CI->config->item('admin_email'), "error handler");
			    $CI->email->to($CI->config->item('admin_email'));
				
			    $CI->email->subject("log " . $_SERVER['REQUEST_URI']);
			    $CI->email->message($message);
				
			    $CI->email->send();
				
				@chmod($filepath, FILE_WRITE_MODE);
			}
			*/
		}
		
		return TRUE;
	}
}