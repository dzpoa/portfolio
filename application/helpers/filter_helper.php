<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if (!function_exists('postFilter'))
{
	function postFilter()
	{
		$aux = array();
		foreach ( $_POST as $key => $value )
		{
			$value = str_replace("--", "", $value);
			$value = str_replace("'", "\'", $value);
			$value = str_replace("`", "\'", $value);
			while (strpos($value, '..') !== FALSE)
			{
				$value = str_replace("..", ".", $value);
			}
			$value = str_replace("\"", "", $value);
			$value = str_replace("\\", "", $value);
			
			$aux[$key] = $value;
		}
		
		$_POST = $aux;
	}
}