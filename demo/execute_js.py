mp_js = require('micropython');
 
(async () => {
  await mp_js;
  await mp_js.init_python(64 * 1024);
  await mp_js.do_str(`
 
  import js
 
  fetch = False
  if isbrowser:
     fetch = JS('fetch')
  else:
     require = JS('require')
     fetch = require('node-fetch')
  response = fetch('https://github.com').wait()
  result = response.text().wait()
  print(result)
  
  `);
})();
