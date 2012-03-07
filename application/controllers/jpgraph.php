<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Jpgraph extends CI_Controller {

	var $colors;
	
	function __construct()
	{
		parent::__construct();
	
		require_once ('jpgraph/jpgraph.php');
		require_once ('jpgraph/jpgraph_pie.php');
		require_once ('jpgraph/jpgraph_pie3d.php');
	
		$this->colors = array('#9D9B86', '#ECC87A', '#DCCCAA', '#827259', '#0F0F0F');
	}
	
	function index()
	{
	}
	
	function technology($id_ = 0)
	{
		if (!is_numeric($id_))
		{
			return;
		}
	
		$data = array();
		$labels = array();
		$colors = array();
	
		$last_pos = "";
		$i = -1;
		$explode = -1;
	
		$technology = new Technology();
		$technology->get();
	
		foreach ($technology as $t)
		{
			if ($t->project->count() > 0)
			{
				$data[] = $t->project->count();
				$labels[] = $t->name . " ({$t->project->count()})";
	
				$pos = rand(0, sizeof($this->colors)-1);
				while ($pos === $last_pos)
				{
					$pos = rand(0, sizeof($this->colors)-1);
				}
				$last_pos = $pos;
	
				$colors[] = $this->colors[$pos];
	
				$i++;
				if ($t->id == $id_)
				{
					$explode = $i;
				}
			}
		}
	
		$colors = $this->clean_colors($colors);
	
		$this->generate($data, $labels, $colors, $explode);
	}
	
	function category($id_ = 0)
	{
		$data = array();
		$labels = array();
		$colors = array();
		
		$last_pos = "";
		$i = -1;
		$explode = -1;
		
		$category = new Category();
		$category->get();
		
		$categories = array();
		foreach ($category as $c)
		{
			if (!array_key_exists($c->name, $categories))
			{
				$categories[$c->name] = array();
			}
		
			$c->technology->get();
			foreach ($c->technology as $t)
			{
				$t->project->get();
				foreach ($t->project as $p)
				{
					if (!in_array($p->id, $categories[$c->name]))
					{
						$categories[$c->name][] = $p->id;
					}
				}
			}
		}
	
		foreach ($categories as $name => $projects)
		{
			$data[] = sizeof($projects);
			$labels[] = $name . " (". sizeof($projects). ")";
		
			$pos = rand(0, sizeof($this->colors)-1);
			while ($pos === $last_pos)
			{
				$pos = rand(0, sizeof($this->colors)-1);
			}
			$last_pos = $pos;
		
			$colors[] = $this->colors[$pos];
		
			$i++;
			$category->get_by_name($name);
			if ($category->id == $id_)
			{
				$explode = $i;
			}
		}
	
		$colors = $this->clean_colors($colors);
	
		$this->generate($data, $labels, $colors, $explode);
	}
	
	function firm($id_ = 0)
	{
		if (!is_numeric($id_))
		{
			return;
		}
	
		$data = array();
		$labels = array();
		$colors = array();
	
		$last_pos = "";
		$i = -1;
		$explode = -1;
	
		$firms = array();
		$firm = new Firm();
	
		foreach ($firm->get() as $f)
		{
			$firms[$f->name] = 0;
	
			foreach ($f->client->get() as $c)
			{
				$firms[$f->name] += $c->where_related('project', 'client_id', $c->id)->count();
			}
		}
	
		foreach ($firms as $name => $projects)
		{
			if ($projects > 0)
			{
				$data[] = $projects;
				$labels[] = $name . " ({$projects})";
	
				$pos = rand(0, sizeof($this->colors)-1);
				while ($pos === $last_pos)
				{
					$pos = rand(0, sizeof($this->colors)-1);
				}
				$last_pos = $pos;
	
				$colors[] = $this->colors[$pos];
	
				$i++;
				$f->get_by_name($name);
				if ($f->id == $id_)
				{
					$explode = $i;
				}
			}
		}
	
		$colors = $this->clean_colors($colors);
	
		$this->generate($data, $labels, $colors, $explode);
	}
	
	function year($year_ = 0)
	{
		if (!is_numeric($year_))
		{
			return;
		}
	
		$data = array();
		$labels = array();
		$colors = array();
	
		$last_pos = "";
		$i = -1;
		$explode = -1;
	
		$project = new Project();
		$project->group_by('year');
	
		$years = array();
		foreach ($project->get() as $p)
		{
			$years[$p->year] = $p->where('year', $p->year)->count();
		}
	
		foreach ($years as $year => $projects)
		{
			if ($projects > 0)
			{
				$data[] = $projects;
				$labels[] = $year . " ({$projects})";
	
				$pos = rand(0, sizeof($this->colors)-1);
				while ($pos === $last_pos)
				{
					$pos = rand(0, sizeof($this->colors)-1);
				}
				$last_pos = $pos;
	
				$colors[] = $this->colors[$pos];
	
				$i++;
				if ($year == $year_)
				{
					$explode = $i;
				}
			}
		}
	
		$colors = $this->clean_colors($colors);
	
		$this->generate($data, $labels, $colors, $explode);
	}
	
	protected function generate($data = array(), $labels = array(), $colors = array(), $explode = -1)
	{
		$graph = new PieGraph(350,250);
	
		$p1 = new PiePlot($data);
		$graph->Add($p1);
	
		if ($explode > -1)
		{
			$p1->ExplodeSlice($explode, 7);
		}
	
		$p1->SetCenter(0.47,0.43);
	
		$p1->SetSliceColors($colors);
	
		$p1->SetLabels($labels);
		$p1->SetGuideLines(true, false);
		$p1->SetLabelPos(1);
		$p1->value->Show();
		$p1->value->SetColor('black');
	
		$graph->Stroke();
	}
	
	protected function clean_colors($colors = array())
	{
		//last color can be the same as the first, lets change that
		//while last color is equal to first, or if the new last color is equal to second-last color
		while ($colors[sizeof($colors)-1] == $colors[0] || $colors[sizeof($colors)-1] == $colors[sizeof($colors)-2])
		{
			$colors[sizeof($colors)-1] = $this->colors[rand(0, sizeof($this->colors)-1)];
		}
	
		return $colors;
	}
}
