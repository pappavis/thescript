<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<html>
    <head>
        <meta charset="utf-8">
        <title> Scargill's Default Web Page op  </title>
        <meta name="description" content="Peter Scargill's default web page installed by THE SCRIPT">
        <meta name="keywords" content="scargill,the script, https://tech.scargill.net">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=yes">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">    
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <link rel="stylesheet" type="text/css" href="reset.css" media="all">
		<link rel="stylesheet" type="text/css" href="/inc/bootstrap/css/bootstrap.min.css" media="all">		
		<link rel="apple-touch-icon" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
		<link rel="icon" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
		<link rel="icon" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
		<link rel="manifest" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/manifest.json">
		<link rel="mask-icon" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
		<link rel="icon" href="https://getbootstrap.com/docs/4.5/assets/img/favicons/favicon.ico">
		<meta name="msapplication-config" content="https://getbootstrap.com/docs/4.5/assets/img/favicons/browserconfig.xml">
		<meta name="theme-color" content="#563d7c">
		<script src="https://unpkg.com/bootstrap-table@1.20.1/dist/extensions/toolbar/bootstrap-table-toolbar.min.js"></script>
		<script src="https://unpkg.com/jspdf@latest/dist/jspdf.umd.min.js"></script>
		<script src="https://raw.githubusercontent.com/eligrey/FileSaver.js/master/dist/FileSaver.js"></script>
		<script src="https://raw.githubusercontent.com/hhurz/tableExport.jquery.plugin/master/tableExport.min.js"></script>
		<style>
		.bighead {
		  background-color: #2094f3;
		  color: white;
		  font-size: 250%;
		  margin: 20px;
		  padding: 20px;
		}
		.padded{

		  padding-top: 16px; 
		}

		A {text-decoration: none;
		   color: #2094f3;
		}

		body {
		background-color: #ffffff;
		}

		p, .author {
			color: #888888;
		}

		</style>
    </head>

	<body>
		<div class="container-lg">
			<table class="table">
				<thead>
					<th>
						<div align="center">
							  <article>
								<nav class="navbar navbar-light bg-light">
									<h1 class="text-dark"><a href="https://github.com/pappavis/thescript" target="_blank">"The Script"</a> Home <script language="JavaScript">  document.write(window.location.hostname)</script><br/></h1>
									<p class="author">geïnspireerd door PETER SCARGILL<br/><br/></p>
								</nav>
							  </article>
						</div>
					</th>
				</thead>
				<tbdody>
					<tr>
						<table class="table table-striped nowrap">
							<tbody>
								<tr>
									<td>
										<div class="padded table rounded">
											<span class="badge text-dark">
												<script language="JavaScript">
													document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':10000' +  '" >Webmin Adminstrator - if installed</a><br/><br/>' );
												 </script>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':1880' +  '" >Node Red Control Panel</a><br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':1880' +  '/ui" >Node Red UI Desktop</a><br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + '/support/owncloud" >owncloud</a><br/' );				
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':3000' +  '" >Grafana</a> indien geïnstalleerd<br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':8888' +  '" >Chronograf - if installed</a><br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':8123' +  '/" >Home assistant</a><br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('<a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':5000' +  '/" >Octoprint</a><br/>' );
										</script>
									</td>
								</tr>
								<tr>
									<td>
										<script language="JavaScript">
											document.write('Apple <a target="_blank" href="' + window.location.protocol + '//' + window.location.hostname + ':8581' +  '/" >Homebridge</a>integratie<br/' );				
										</script>
									</td>
								</tr>
							</tbody>
						</table>						
					</tr>
					<tr>
						<td>
							<div align="center" class-"author container-sm">Diverse utils en tekst bewerkings zijn geinstalleerd.</div>						
						</td>
					</tr>
				</tbdody>
			</table>
		</div>
	</body>
</html>
