import glob
P = 'public'
JS = ('var _w=document.write;document.write=function(s){if(location.hostname.indexOf("github.io")<0||location.search.indexOf("rootbase=1")>=0){'
      's=String(s).split("/nelvo-preview/").join("/").split("\\"/nelvo-preview\\"").join("\\"/\\"").split("\'/nelvo-preview\'").join("\'/\'")}'
      'return _w.call(document,s)};')
key = 'document.open();document.write('
n = 0
for f in glob.glob(P + '/**/*.html', recursive=True):
    s = open(f, encoding='utf-8').read()
    if key in s and 'rootbase=1' not in s:
        s = s.replace(key, JS + key, 1)
        open(f, 'w', encoding='utf-8').write(s)
        n += 1
print('rootbase patched', n)
