// 修复标题里的脚注无法回跳的问题。
// mdBook 会把标题文字包在 <a class="header"> 里，标题中的脚注链接就成了嵌套链接，
// 浏览器解析时会把脚注链接拆到 <sup> 外面，导致回跳锚点 #fr-N-M 变成空元素。
// 这里把拆散的部分重新拼回去，并移到标题链接后面（位置不变，结构合法）。
document.querySelectorAll('a.header sup.footnote-reference:empty').forEach(function (sup) {
  var header = sup.closest('a.header');
  var link = header.nextElementSibling;
  if (link && link.matches('a[href^="#footnote-"]')) {
    sup.appendChild(link);
    header.after(sup);
  }
});
