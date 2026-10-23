/* TAARV: visitors never see the word "AI". Rewrites visible text, including live status messages. */
(function(){
if(window.__tvText)return;window.__tvText=1;
var R=[[/Getting the AI ready/g,'Getting ready'],[/Downloading the AI upscaler/g,'Downloading the upscaler'],
[/\s*(?:with|by|using)\s+on-device\s+AI\b/gi,' on this device'],[/\s*(?:with|by|using)\s+AI\b/gi,''],
[/\bthe AI (enhancer|upscaler|model)\b/gi,'the $1'],[/\bAI[- ]upscaling\b/gi,'Upscaling'],
[/\bon-device AI\b/gi,'on-device processing'],[/\bAI\s+/g,''],[/\bAI\b/g,'']];
function fix(t){var o=t;for(var i=0;i<R.length;i++)o=o.replace(R[i][0],R[i][1]);return o===t?t:o.replace(/\s{2,}/g,' ').replace(/ ([.,\u2026%])/g,'$1')}
function walk(n){if(n.nodeType===3){if(/\bAI\b/.test(n.nodeValue)){var v=fix(n.nodeValue);if(v!==n.nodeValue)n.nodeValue=v}return}
if(n.nodeType!==1)return;var tg=n.tagName;if(tg==='SCRIPT'||tg==='STYLE'||tg==='TEXTAREA'||tg==='NOSCRIPT')return;
for(var c=n.firstChild;c;c=c.nextSibling)walk(c)}
function run(){walk(document.body||document.documentElement)}
function start(){run();new MutationObserver(function(ms){for(var i=0;i<ms.length;i++){var m=ms[i];if(m.type==='characterData')walk(m.target);else for(var j=0;j<m.addedNodes.length;j++)walk(m.addedNodes[j])}}).observe(document.documentElement,{childList:true,subtree:true,characterData:true})}
if(document.body)start();else document.addEventListener('DOMContentLoaded',start);
})();
