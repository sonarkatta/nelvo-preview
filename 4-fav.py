import glob, os, shutil
P = 'public'
def cp(src, dst):
    if os.path.isdir(os.path.dirname(dst) or '.'):
        shutil.copyfile(src, dst)
for n in ('taarv-master-light.png', 'taarv-master-dark.png'):
    cp('logo-master.png', P + '/' + n)
cp('logo-512.png', P + '/taarv-logo-small.png')
cp('favicon-64.png', P + '/favicon.png')
for f in glob.glob(P + '/**/taarv-logo.png', recursive=True):
    cp('logo-512.png', f)
JS = ("var l=document.querySelectorAll('link[rel*=icon]');for(var i=0;i<l.length;i++)l[i].parentNode.removeChild(l[i]);"
      "var k=document.createElement('link');k.rel='icon';k.type='image/png';k.href='/nelvo-preview/favicon.png?v=logo2';document.head.appendChild(k);")
stmt = 'h+="<scr"+"ipt>' + JS + '</scr"+"ipt>";'
key = 'document.open();document.write('
n = 0
for f in glob.glob(P + '/**/*.html', recursive=True):
    s = open(f, encoding='utf-8').read()
    if key in s and 'logo2' not in s:
        s = s.replace(key, stmt + key, 1)
        open(f, 'w', encoding='utf-8').write(s)
        n += 1
print('favicon patched', n)
