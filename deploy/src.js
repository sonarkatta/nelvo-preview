// src.js
var src_default = { async fetch(req, env) {
  const a = req.headers.get("Authorization") || "";
  let ok = false;
  if (a.startsWith("Basic ")) {
    try {
      const d = atob(a.slice(6));
      const i = d.indexOf(":");
      ok = d.slice(0, i) === "taarv" && d.slice(i + 1) === env.PREVIEW_PW;
    } catch (e) {
    }
  }
  if (!ok)
    return new Response("Locked", { status: 401, headers: { "WWW-Authenticate": 'Basic realm="TAARV preview"', "X-Robots-Tag": "noindex" } });
  const r = await env.ASSETS.fetch(req);
  const h = new Headers(r.headers);
  h.set("X-Robots-Tag", "noindex");
  h.set("Cache-Control", "no-store");
  return new Response(r.body, { status: r.status, headers: h });
} };
export {
  src_default as default
};
//# sourceMappingURL=src.js.map
