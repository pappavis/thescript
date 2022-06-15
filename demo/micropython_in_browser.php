<?php
<!doctype html>
<html>
  <head>
    <title>Micripython in jouw browser</title>
    <script src="/var/www/html/static/js/micropython.js"></script>
	<link rel="stylesheet" type="text/css" href="/inc/bootstrap/css/bootstrap.min.css" media="all">		
  </head>
  <body>
	<div class="container-lg">
		<pre id="mp_js_stdout"></pre>
		<script>
			setTimeout(function() {
				document.getElementById('mp_js_stdout').addEventListener('print', function(e) {
					document.getElementById('mp_js_stdout').innerText += e.data;
				}, false);

				mp_js_init(64 * 1024);
				mp_js_do_str('print(\'hallo wereld\')');
			}, 1000);
		</script>
	</div>
  </body>
</html>
?>
