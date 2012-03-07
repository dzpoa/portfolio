<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Daniel Zander's Programming Portfolio</title>
		<link href='http://fonts.googleapis.com/css?family=Kaushan+Script|Puritan' rel='stylesheet' type='text/css'>
		
		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script>
		<script type="text/javascript" src="js/wtooltip.js"></script>
		<script type="text/javascript" src="js/jquery.validationEngine-en.js" charset="utf-8"></script>
		<script type="text/javascript" src="js/jquery.validationEngine.js" charset="utf-8"></script>
		<script type="text/javascript" src="js/jquery.slideto.js"></script>
		
		<script type="text/javascript" src="js/home.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/home.css" />
		<link rel="stylesheet" type="text/css" href="css/jquery-ui-1.8.17.custom.css" />
		<link rel="stylesheet" type="text/css" href="css/validationEngine.jquery.css" />
	</head>
	<body>
		<div id="container">
			<div id="top">
				<p id="title" class="kaushan">Daniel Zander's Programming Portfolio</p>
			</div>
			
			<div id="menu-bar">				
				<div class="menu">
					<ul>
						<li><a href="#" id="m-about-me">About me</a></li>
						<li><a href="#" id="m-about-site">About this site</a></li>
						<li><a href="#" id="m-previous-projects">Previous projects</a></li>
						<li><a href="#" id="m-summary">Summary of projects</a></li>
						<li><a href="#" id="m-contact">Contact</a></li>
					</ul>
				</div>
			</div>
			
			<h1 class="kaushan m-about-me">About me</h1>
			<p class="lorem">
				[~$about_me~]
			</p>
			
			<h1 class="kaushan m-about-site">About this site</h1>
			<p class="lorem">
				[~$about_site~]
			</p>
			
			<ul class="tools">
				[~foreach $tools as $tool~]
					<li>[~$tool~];</li>
				[~/foreach~]
			</ul>
			
			<h1 class="kaushan m-previous-projects">Previous Projects (by clients)</h1>
			<div id="accordion">
				[~foreach $clients as $client~]
				<h3 id="c-[~$client.id~]"><a href="#">[~$client.name~]</a></h3>
					<div>
						Url: [~$client.url~]<br />
						Firm: [~$client.firm~]<br />
						[~foreach $client.projects as $project~]
							<br />
							Project Name: [~$project.name~]<br />
							Year: <span class='tooltip year' id='[~$project.year~]'>[~$project.year~]</span><br />
							Description: [~$project.description~]<br />
							Technologies: 
							[~foreach from=$project.technologies key=key item=technology name=foo~]
							<span class='tooltip technology' id='[~$technology.id~]'>[~$technology.name~]</span> (<span class='tooltip category' id='[~$technology.category_id~]'>[~$technology.category_name~]</span>)[~if not $smarty.foreach.foo.last~],[~/if~]
							[~/foreach~]
							<br />
						[~/foreach~]
					</div>
				[~/foreach~]
			</div>
			
			<h1 class="kaushan m-summary">Summary of projects</h1>
			<div id="graphs" style="align='center'">
				<div>
					<h3 class="kaushan">Technologies</h3>
					<p><img src="jpgraph/technology" /></p>
				</div>
				
				<div>
					<h3 class="kaushan">Categories</h3>
					<p><img src="jpgraph/category" /></p>
				</div>
			
				<div>
					<h3 class="kaushan">Firms</h3>
					<p><img src="jpgraph/firm" /></p>
				</div>
				
				<div>
					<h3 class="kaushan">Years</h3>
					<p><img src="jpgraph/year" /></p>
				</div>
			</div>
			
			<h1 class="kaushan m-contact">Contact</h1>
			<p class="lorem">If you have interest in hire me or keep in touch, please fill the form below!</p>
			<div id="form">
				<form id="contact" method="POST" action="">
					<fieldset>
						<label for="name">Name</label>
						<input type="text" name="name" id="name" class="validate[required,minSize[3],maxSize[250]]" />
					</fieldset>
					<fieldset>
						<label for="email">Email</label>
						<input type="text" name="email" id="email" class="validate[required,custom[email],minSize[5],maxSize[250]]" />
					</fieldset>
					<fieldset>
						<label for="company">Company</label>
						<input type="text" name="company" id="company" class="validate[minSize[3],maxSize[250]]" />
					</fieldset>
					<fieldset>
						<label for="message" id="label-message">Message</label>
						<textarea name="message" id="message" class="validate[required,minSize[15],maxSize[5000]]"></textarea>
					</fieldset>
					<fieldset>
						<div id="captcha-refresh">
							<div id="captcha-image">[~$captcha~]</div>
							<img src="img/refresh-static.gif" id="refresh" />
						</div>
						<label for="captcha" id="label-captcha">Please type the characters show above</label>
						<input type="text" name="captcha" id="captcha-field" value="" class="validate[required,onlyLetterNumber]" />
					</fieldset>
					<fieldset>
						<input type="hidden" name="token" value="[~$token~]" />
						<div id="send-sending">
							<span id="send">Send</span>
							<img src="img/loading.gif" id="sending" />
							<p id="feedback"></p>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</body>
</html>
