﻿// Knockout JavaScript library v1.3.0beta
// (c) Steven Sanderson - http://knockoutjs.com/
// License: MIT (http://www.opensource.org/licenses/mit-license.php)

(function (window, undefined) {
    function c(b) { throw b; } var l = void 0, o = null, r = window.ko = {}; r.b = function (b, e) { for (var d = b.split("."), a = window, f = 0; f < d.length - 1; f++) a = a[d[f]]; a[d[d.length - 1]] = e }; r.l = function (b, e, d) { b[e] = d };
    r.a = new function () {
        function b(a, f) { if (a.tagName != "INPUT" || !a.type) return !1; if (f.toLowerCase() != "click") return !1; var g = a.type.toLowerCase(); return g == "checkbox" || g == "radio" } var e = /^(\s|\u00A0)+|(\s|\u00A0)+$/g, d = { click: 1, dblclick: 1, mousedown: 1, mouseup: 1, mousemove: 1, mouseover: 1, mouseout: 1, mouseenter: 1, mouseleave: 1 }; return { Ba: ["authenticity_token", /^__RequestVerificationToken(_.*)?$/], p: function (a, f) { for (var g = 0, b = a.length; g < b; g++) f(a[g]) }, k: function (a, f) {
            if (typeof a.indexOf == "function") return a.indexOf(f);
            for (var g = 0, b = a.length; g < b; g++) if (a[g] === f) return g; return -1
        }, Ta: function (a, f, g) { for (var b = 0, d = a.length; b < d; b++) if (f.call(g, a[b])) return a[b]; return o }, ba: function (a, f) { var g = r.a.k(a, f); g >= 0 && a.splice(g, 1) }, aa: function (a, f) { for (var a = a || [], g = [], b = 0, d = a.length; b < d; b++) g.push(f(a[b])); return g }, $: function (a, f) { for (var a = a || [], g = [], b = 0, d = a.length; b < d; b++) f(a[b]) && g.push(a[b]); return g }, J: function (a, f) { for (var g = 0, b = f.length; g < b; g++) a.push(f[g]); return a }, extend: function (a, f) {
            for (var b in f) f.hasOwnProperty(b) &&
(a[b] = f[b]); return a
        }, L: function (a) { for (; a.firstChild; ) r.removeNode(a.firstChild) }, pa: function (a, f) { r.a.L(a); f && r.a.p(f, function (f) { a.appendChild(f) }) }, Ia: function (a, f) { var b = a.nodeType ? [a] : a; if (b.length > 0) { for (var d = b[0], e = d.parentNode, i = 0, k = f.length; i < k; i++) e.insertBefore(f[i], d); i = 0; for (k = b.length; i < k; i++) r.removeNode(b[i]) } }, Ka: function (a, f) { navigator.userAgent.indexOf("MSIE 6") >= 0 ? a.setAttribute("selected", f) : a.selected = f }, v: function (a) { return (a || "").replace(e, "") }, Bb: function (a, f) {
            for (var b =
[], d = (a || "").split(f), e = 0, i = d.length; e < i; e++) { var k = r.a.v(d[e]); k !== "" && b.push(k) } return b
        }, zb: function (a, f) { a = a || ""; return f.length > a.length ? !1 : a.substring(0, f.length) === f }, eb: function (a) { for (var f = Array.prototype.slice.call(arguments, 1), b = "return (" + a + ")", d = 0; d < f.length; d++) f[d] && typeof f[d] == "object" && (b = "with(sc[" + d + "]) { " + b + " } "); return (new Function("sc", b))(f) }, bb: function (a, f) { if (f.compareDocumentPosition) return (f.compareDocumentPosition(a) & 16) == 16; for (; a != o; ) { if (a == f) return !0; a = a.parentNode } return !1 },
            ga: function (a) { return r.a.bb(a, document) }, s: function (a, f, g) { if (typeof jQuery != "undefined") { if (b(a, f)) var d = g, g = function (a, f) { var b = this.checked; if (f) this.checked = f.Va !== !0; d.call(this, a); this.checked = b }; jQuery(a).bind(f, g) } else typeof a.addEventListener == "function" ? a.addEventListener(f, g, !1) : typeof a.attachEvent != "undefined" ? a.attachEvent("on" + f, function (f) { g.call(a, f) }) : c(Error("Browser doesn't support addEventListener or attachEvent")) }, ta: function (a, f) {
                (!a || !a.nodeType) && c(Error("element must be a DOM node when calling triggerEvent"));
                if (typeof jQuery != "undefined") { var g = []; b(a, f) && g.push({ Va: a.checked }); jQuery(a).trigger(f, g) } else if (typeof document.createEvent == "function") typeof a.dispatchEvent == "function" ? (g = document.createEvent(f in d ? "MouseEvents" : "HTMLEvents"), g.initEvent(f, !0, !0, window, 0, 0, 0, 0, 0, !1, !1, !1, !1, 0, a), a.dispatchEvent(g)) : c(Error("The supplied element doesn't support dispatchEvent")); else if (typeof a.fireEvent != "undefined") {
                    if (f == "click" && a.tagName == "INPUT" && (a.type.toLowerCase() == "checkbox" || a.type.toLowerCase() ==
"radio")) a.checked = a.checked !== !0; a.fireEvent("on" + f)
                } else c(Error("Browser doesn't support triggering events"))
            }, d: function (a) { return r.T(a) ? a() : a }, ab: function (a, f) { return r.a.k((a.className || "").split(/\s+/), f) >= 0 }, Oa: function (a, f, b) { var d = r.a.ab(a, f); if (b && !d) a.className = (a.className || "") + " " + f; else if (d && !b) { for (var b = (a.className || "").split(/\s+/), d = "", e = 0; e < b.length; e++) b[e] != f && (d += b[e] + " "); a.className = r.a.v(d) } }, outerHTML: function (a) {
                var f = a.outerHTML; if (typeof f == "string") return f; f = window.document.createElement("div");
                f.appendChild(a.cloneNode(!0)); return f.innerHTML
            }, ub: function (a, f) { for (var a = r.a.d(a), f = r.a.d(f), b = [], d = a; d <= f; d++) b.push(d); return b }, la: function (a) { for (var f = [], b = 0, d = a.length; b < d; b++) f.push(a[b]); return f }, ja: /MSIE 6/i.test(navigator.userAgent), lb: /MSIE 7/i.test(navigator.userAgent), Ca: function (a, f) {
                for (var b = r.a.la(a.getElementsByTagName("INPUT")).concat(r.a.la(a.getElementsByTagName("TEXTAREA"))), d = typeof f == "string" ? function (a) { return a.name === f } : function (a) { return f.test(a.name) }, e = [], i = b.length -
1; i >= 0; i--) d(b[i]) && e.push(b[i]); return e
            }, rb: function (a) { return typeof a == "string" && (a = r.a.v(a)) ? window.JSON && window.JSON.parse ? window.JSON.parse(a) : (new Function("return " + a))() : o }, ra: function (a) { (typeof JSON == "undefined" || typeof JSON.stringify == "undefined") && c(Error("Cannot find JSON.stringify(). Some browsers (e.g., IE < 8) don't support it natively, but you can overcome this by adding a script reference to json2.js, downloadable from http://www.json.org/json2.js")); return JSON.stringify(r.a.d(a)) },
            sb: function (a, f, b) {
                var b = b || {}, d = b.params || {}, e = b.includeFields || this.Ba, i = a; if (typeof a == "object" && a.tagName == "FORM") for (var i = a.action, k = e.length - 1; k >= 0; k--) for (var m = r.a.Ca(a, e[k]), q = m.length - 1; q >= 0; q--) d[m[q].name] = m[q].value; var f = r.a.d(f), p = document.createElement("FORM"); p.style.display = "none"; p.action = i; p.method = "post"; for (var n in f) a = document.createElement("INPUT"), a.name = n, a.value = r.a.ra(r.a.d(f[n])), p.appendChild(a); for (n in d) a = document.createElement("INPUT"), a.name = n, a.value = d[n], p.appendChild(a);
                document.body.appendChild(p); b.submitter ? b.submitter(p) : p.submit(); setTimeout(function () { p.parentNode.removeChild(p) }, 0)
            } 
        }
    }; r.b("ko.utils", r.a); r.b("ko.utils.arrayForEach", r.a.p); r.b("ko.utils.arrayFirst", r.a.Ta); r.b("ko.utils.arrayFilter", r.a.$); r.b("ko.utils.arrayGetDistinctValues", r.a.Ab); r.b("ko.utils.arrayIndexOf", r.a.k); r.b("ko.utils.arrayMap", r.a.aa); r.b("ko.utils.arrayPushAll", r.a.J); r.b("ko.utils.arrayRemoveItem", r.a.ba); r.b("ko.utils.extend", r.a.extend);
    r.b("ko.utils.fieldsIncludedWithJsonPost", r.a.Ba); r.b("ko.utils.getFormFields", r.a.Ca); r.b("ko.utils.postJson", r.a.sb); r.b("ko.utils.parseJson", r.a.rb); r.b("ko.utils.registerEventHandler", r.a.s); r.b("ko.utils.stringifyJson", r.a.ra); r.b("ko.utils.range", r.a.ub); r.b("ko.utils.toggleDomNodeCssClass", r.a.Oa); r.b("ko.utils.triggerEvent", r.a.ta); r.b("ko.utils.unwrapObservable", r.a.d);
    Function.prototype.bind || (Function.prototype.bind = function (b) { var e = this, d = Array.prototype.slice.call(arguments), b = d.shift(); return function () { return e.apply(b, d.concat(Array.prototype.slice.call(arguments))) } });
    r.a.e = new function () { var b = 0, e = "__ko__" + (new Date).getTime(), d = {}; return { get: function (a, f) { var b = r.a.e.getAll(a, !1); return b === l ? l : b[f] }, set: function (a, f, b) { b === l && r.a.e.getAll(a, !1) === l || (r.a.e.getAll(a, !0)[f] = b) }, getAll: function (a, f) { var g = a[e]; if (!(g && g !== "null")) { if (!f) return; g = a[e] = "ko" + b++; d[g] = {} } return d[g] }, clear: function (a) { var f = a[e]; f && (delete d[f], a[e] = o) } } }; r.b("ko.utils.domData", r.a.e); r.b("ko.utils.domData.clear", r.a.e.clear);
    r.a.w = new function () {
        function b(a, f) { var b = r.a.e.get(a, d); b === l && f && (b = [], r.a.e.set(a, d, b)); return b } function e(a) { var f = b(a, !1); if (f) for (var f = f.slice(0), d = 0; d < f.length; d++) f[d](a); r.a.e.clear(a); typeof jQuery == "function" && typeof jQuery.cleanData == "function" && jQuery.cleanData([a]) } var d = "__ko_domNodeDisposal__" + (new Date).getTime(); return { wa: function (a, f) { typeof f != "function" && c(Error("Callback must be a function")); b(a, !0).push(f) }, Ha: function (a, f) {
            var g = b(a, !1); g && (r.a.ba(g, f), g.length == 0 && r.a.e.set(a,
d, l))
        }, H: function (a) { if (!(a.nodeType != 1 && a.nodeType != 9)) { e(a); var b = []; r.a.J(b, a.getElementsByTagName("*")); for (var a = 0, d = b.length; a < d; a++) e(b[a]) } }, removeNode: function (a) { r.H(a); a.parentNode && a.parentNode.removeChild(a) } 
        }
    }; r.H = r.a.w.H; r.removeNode = r.a.w.removeNode; r.b("ko.cleanNode", r.H); r.b("ko.removeNode", r.removeNode); r.b("ko.utils.domNodeDisposal", r.a.w); r.b("ko.utils.domNodeDisposal.addDisposeCallback", r.a.w.wa); r.b("ko.utils.domNodeDisposal.removeDisposeCallback", r.a.w.Ha);
    (function () {
        function b(b) {
            for (var b = b || "", a = []; b.match(e); ) b = b.replace(e, function (b, f, d) { f && a.push(document.createTextNode(f)); a.push(document.createComment(d)); return "" }); var f = r.a.v(b).toLowerCase(), g = document.createElement("div"), f = f.match(/^<(thead|tbody|tfoot)/) && [1, "<table>", "</table>"] || !f.indexOf("<tr") && [2, "<table><tbody>", "</tbody></table>"] || (!f.indexOf("<td") || !f.indexOf("<th")) && [3, "<table><tbody><tr>", "</tr></tbody></table>"] || [0, "", ""]; for (g.innerHTML = f[1] + b + f[2]; f[0]--; ) g = g.lastChild;
            return a.concat(r.a.la(g.childNodes))
        } var e = /^(\s*)<\!--(.*?)--\>/; r.a.V = function (d) { return typeof jQuery != "undefined" ? jQuery.clean([d]) : b(d) }; r.a.xb = function (b, a) { r.a.L(b); if (a !== o && a !== l) if (typeof a != "string" && (a = a.toString()), typeof jQuery != "undefined") jQuery(b).html(a); else for (var f = r.a.V(a), g = 0; g < f.length; g++) b.appendChild(f[g]) } 
    })(); r.b("ko.utils.parseHtmlFragment", r.a.V);
    r.q = function () {
        function b() { return ((1 + Math.random()) * 4294967296 | 0).toString(16).substring(1) } function e(a, b) { if (a) if (a.nodeType == 8) { var d = r.q.Fa(a.nodeValue); d != o && b.push({ $a: a, pb: d }) } else if (a.nodeType == 1) for (var d = 0, h = a.childNodes, j = h.length; d < j; d++) e(h[d], b) } var d = {}; return { ma: function (a) { typeof a != "function" && c(Error("You can only pass a function to ko.memoization.memoize()")); var f = b() + b(); d[f] = a; return "<\!--[ko_memo:" + f + "]--\>" }, Pa: function (a, b) {
            var g = d[a]; g === l && c(Error("Couldn't find any memo with ID " +
a + ". Perhaps it's already been unmemoized.")); try { return g.apply(o, b || []), !0 } finally { delete d[a] } 
        }, Qa: function (a, b) { var d = []; e(a, d); for (var h = 0, j = d.length; h < j; h++) { var i = d[h].$a, k = [i]; b && r.a.J(k, b); r.q.Pa(d[h].pb, k); i.nodeValue = ""; i.parentNode && i.parentNode.removeChild(i) } }, Fa: function (a) { return (a = a.match(/^\[ko_memo\:(.*?)\]$/)) ? a[1] : o } 
        }
    } (); r.b("ko.memoization", r.q); r.b("ko.memoization.memoize", r.q.ma); r.b("ko.memoization.unmemoize", r.q.Pa); r.b("ko.memoization.parseMemoText", r.q.Fa);
    r.b("ko.memoization.unmemoizeDomNodeAndDescendants", r.q.Qa); r.Aa = { throttle: function (b, e) { b.throttleEvaluation = e; var d = o; return r.h({ read: b, write: function (a) { clearTimeout(d); d = setTimeout(function () { b(a) }, e) } }) } }; r.b("ko.extenders", r.Aa); r.Ma = function (b, e) { this.ca = b; this.Za = e; r.l(this, "dispose", this.u) }; r.Ma.prototype.u = function () { this.kb = !0; this.Za() };
    r.P = function () { this.Q = []; r.a.extend(this, r.P.fn); r.l(this, "subscribe", this.sa); r.l(this, "extend", this.extend); r.l(this, "notifySubscribers", this.N); r.l(this, "getSubscriptionsCount", this.hb) };
    r.P.fn = { sa: function (b, e) { var d = e ? b.bind(e) : b, a = new r.Ma(d, function () { r.a.ba(this.Q, a) } .bind(this)); this.Q.push(a); return a }, N: function (b) { r.a.p(this.Q.slice(0), function (e) { e && e.kb !== !0 && e.ca(b) }) }, hb: function () { return this.Q.length }, extend: function (b) { var e = this; if (b) for (var d in b) { var a = r.Aa[d]; typeof a == "function" && (e = a(e, b[d])) } return e } }; r.Ea = function (b) { return typeof b.sa == "function" && typeof b.N == "function" }; r.b("ko.subscribable", r.P); r.b("ko.isSubscribable", r.Ea);
    r.R = function () { var b = []; return { Ua: function (e) { b.push({ ca: e, za: [] }) }, end: function () { b.pop() }, Ga: function (e) { r.Ea(e) || c("Only subscribable things can act as dependencies"); if (b.length > 0) { var d = b[b.length - 1]; r.a.k(d.za, e) >= 0 || (d.za.push(e), d.ca(e)) } } } } (); var x = { undefined: !0, "boolean": !0, number: !0, string: !0 };
    r.z = function (b) { function e() { if (arguments.length > 0) { if (!e.equalityComparer || !e.equalityComparer(d, arguments[0])) d = arguments[0], e.N(d); return this } else return r.R.Ga(e), d } var d = b; r.P.call(e); e.Y = function () { e.N(d) }; r.a.extend(e, r.z.fn); r.l(e, "valueHasMutated", e.Y); return e }; r.z.fn = { A: r.z, equalityComparer: function (b, e) { return b === o || typeof b in x ? b === e : !1 } }; r.T = function (b) { return b === o || b === l || b.A === l ? !1 : b.A === r.z ? !0 : r.T(b.A) };
    r.M = function (b) { return typeof b == "function" && b.A === r.z ? !0 : typeof b == "function" && b.A === r.h && b.ib ? !0 : !1 }; r.b("ko.observable", r.z); r.b("ko.isObservable", r.T); r.b("ko.isWriteableObservable", r.M);
    r.O = function (b) { arguments.length == 0 && (b = []); b !== o && b !== l && !("length" in b) && c(Error("The argument passed when initializing an observable array must be an array, or null, or undefined.")); var e = new r.z(b); r.a.extend(e, r.O.fn); r.l(e, "remove", e.remove); r.l(e, "removeAll", e.vb); r.l(e, "destroy", e.fa); r.l(e, "destroyAll", e.Ya); r.l(e, "indexOf", e.indexOf); r.l(e, "replace", e.replace); return e };
    r.O.fn = { remove: function (b) { for (var e = this(), d = [], a = [], f = typeof b == "function" ? b : function (a) { return a === b }, g = 0, h = e.length; g < h; g++) { var j = e[g]; f(j) ? a.push(j) : d.push(j) } this(d); return a }, vb: function (b) { if (b === l) { var e = this(); this([]); return e } return !b ? [] : this.remove(function (d) { return r.a.k(b, d) >= 0 }) }, fa: function (b) { for (var e = this(), d = typeof b == "function" ? b : function (a) { return a === b }, a = e.length - 1; a >= 0; a--) d(e[a]) && (e[a]._destroy = !0); this.Y() }, Ya: function (b) {
        return b === l ? this.fa(function () { return !0 }) : !b ?
[] : this.fa(function (e) { return r.a.k(b, e) >= 0 })
    }, indexOf: function (b) { var e = this(); return r.a.k(e, b) }, replace: function (b, e) { var d = this.indexOf(b); d >= 0 && (this()[d] = e, this.Y()) } 
    }; r.a.p("pop,push,reverse,shift,sort,splice,unshift".split(","), function (b) { r.O.fn[b] = function () { var e = this(), e = e[b].apply(e, arguments); this.Y(); return e } }); r.a.p(["slice"], function (b) { r.O.fn[b] = function () { var e = this(); return e[b].apply(e, arguments) } }); r.b("ko.observableArray", r.O);
    function y(b, e, d) { b && typeof b == "object" ? d = b : (d = d || {}, d.read = b || d.read, d.owner = e || d.owner); typeof d.read != "function" && c("Pass a function that returns the value of the dependentObservable"); return d }
    r.h = function (b, e, d) {
        function a() { r.a.p(p, function (a) { a.u() }); p = [] } function f() { var a = h.throttleEvaluation; a && a >= 0 ? (clearTimeout(n), n = setTimeout(g, a)) : g() } function g() { if (i && typeof d.disposeWhen == "function" && d.disposeWhen()) h.u(); else { try { a(), r.R.Ua(function (a) { p.push(a.sa(f)) }), j = d.owner ? d.read.call(d.owner) : d.read() } finally { r.R.end() } h.N(j); i = !0 } } function h() {
            if (arguments.length > 0) typeof d.write === "function" ? d.write.apply(d.owner, arguments) : c("Cannot write a value to a dependentObservable unless you specify a 'write' option. If you wish to read the current value, don't pass any parameters.");
            else return i || g(), r.R.Ga(h), j
        } var j, i = !1, d = y(b, e, d), k = typeof d.disposeWhenNodeIsRemoved == "object" ? d.disposeWhenNodeIsRemoved : o, m = o; if (k) { m = function () { h.u() }; r.a.w.wa(k, m); var q = d.disposeWhen; d.disposeWhen = function () { return !r.a.ga(k) || typeof q == "function" && q() } } var p = [], n = o; h.gb = function () { return p.length }; h.ib = typeof d.write === "function"; h.u = function () { k && r.a.w.Ha(k, m); a() }; r.P.call(h); r.a.extend(h, r.h.fn); d.deferEvaluation !== !0 && g(); r.l(h, "dispose", h.u); r.l(h, "getDependenciesCount", h.gb); return h
    };
    r.h.fn = { A: r.h }; r.h.A = r.z; r.b("ko.dependentObservable", r.h); r.b("ko.computed", r.h);
    (function () {
        function b(a, f, g) { g = g || new d; a = f(a); if (!(typeof a == "object" && a !== o && a !== l)) return a; var h = a instanceof Array ? [] : {}; g.save(a, h); e(a, function (d) { var e = f(a[d]); switch (typeof e) { case "boolean": case "number": case "string": case "function": h[d] = e; break; case "object": case "undefined": var k = g.get(e); h[d] = k !== l ? k : b(e, f, g) } }); return h } function e(a, b) { if (a instanceof Array) for (var d = 0; d < a.length; d++) b(d); else for (d in a) b(d) } function d() {
            var a = [], b = []; this.save = function (d, e) {
                var j = r.a.k(a, d); j >= 0 ?
b[j] = e : (a.push(d), b.push(e))
            }; this.get = function (d) { d = r.a.k(a, d); return d >= 0 ? b[d] : l } 
        } r.Na = function (a) { arguments.length == 0 && c(Error("When calling ko.toJS, pass the object you want to convert.")); return b(a, function (a) { for (var b = 0; r.T(a) && b < 10; b++) a = a(); return a }) }; r.toJSON = function (a) { a = r.Na(a); return r.a.ra(a) } 
    })(); r.b("ko.toJS", r.Na); r.b("ko.toJSON", r.toJSON);
    r.j = { r: function (b) { return b.tagName == "OPTION" ? b.__ko__hasDomDataOptionValue__ === !0 ? r.a.e.get(b, r.c.options.na) : b.getAttribute("value") : b.tagName == "SELECT" ? b.selectedIndex >= 0 ? r.j.r(b.options[b.selectedIndex]) : l : b.value }, Z: function (b, e) {
        if (b.tagName == "OPTION") switch (typeof e) {
            case "string": case "number": r.a.e.set(b, r.c.options.na, l); "__ko__hasDomDataOptionValue__" in b && delete b.__ko__hasDomDataOptionValue__; b.value = e; break; default: r.a.e.set(b, r.c.options.na, e), b.__ko__hasDomDataOptionValue__ = !0, b.value =
""
        } else if (b.tagName == "SELECT") for (var d = b.options.length - 1; d >= 0; d--) { if (r.j.r(b.options[d]) == e) { b.selectedIndex = d; break } } else { if (e === o || e === l) e = ""; b.value = e } 
    } 
    }; r.b("ko.selectExtensions", r.j); r.b("ko.selectExtensions.readValue", r.j.r); r.b("ko.selectExtensions.writeValue", r.j.Z);
    r.i = function () {
        function b(a, b) { for (var d = o; a != d; ) d = a, a = a.replace(e, function (a, f) { return b[f] }); return a } var e = /\@ko_token_(\d+)\@/g, d = /^[\_$a-z][\_$a-z0-9]*(\[.*?\])*(\.[\_$a-z][\_$a-z0-9]*(\[.*?\])*)*$/i, a = ["true", "false"]; return { B: [], W: function (a) {
            var d = r.a.v(a); if (d.length < 3) return []; d.charAt(0) === "{" && (d = d.substring(1, d.length - 1)); for (var a = [], e = o, j, i = 0; i < d.length; i++) {
                var k = d.charAt(i); if (e === o) switch (k) { case '"': case "'": case "/": e = i, j = k } else if (k == j && d.charAt(i - 1) !== "\\") {
                    k = d.substring(e, i +
1); a.push(k); var m = "@ko_token_" + (a.length - 1) + "@", d = d.substring(0, e) + m + d.substring(i + 1); i -= k.length - m.length; e = o
                } 
            } j = e = o; for (var q = 0, p = o, i = 0; i < d.length; i++) { k = d.charAt(i); if (e === o) switch (k) { case "{": e = i; p = k; j = "}"; break; case "(": e = i; p = k; j = ")"; break; case "[": e = i, p = k, j = "]" } k === p ? q++ : k === j && (q--, q === 0 && (k = d.substring(e, i + 1), a.push(k), m = "@ko_token_" + (a.length - 1) + "@", d = d.substring(0, e) + m + d.substring(i + 1), i -= k.length - m.length, e = o)) } j = []; d = d.split(","); e = 0; for (i = d.length; e < i; e++) q = d[e], p = q.indexOf(":"), p > 0 &&
p < q.length - 1 ? (k = q.substring(p + 1), j.push({ key: b(q.substring(0, p), a), value: b(k, a) })) : j.push({ unknown: b(q, a) }); return j
        }, ia: function (b) {
            for (var e = typeof b === "string" ? r.i.W(b) : b, h = [], b = [], j, i = 0; j = e[i]; i++) if (h.length > 0 && h.push(","), j.key) {
                var k; a: { k = j.key; var m = r.a.v(k); switch (m.length && m.charAt(0)) { case "'": case '"': break a; default: k = "'" + m + "'" } } j = j.value; h.push(k); h.push(":"); h.push(j); m = r.a.v(j); if (r.a.k(a, r.a.v(m).toLowerCase()) >= 0 ? 0 : m.match(d) !== o) b.length > 0 && b.push(", "), b.push(k + " : function(__ko_value) { " +
j + " = __ko_value; }")
            } else j.unknown && h.push(j.unknown); e = h.join(""); b.length > 0 && (e = e + ", '_ko_property_writers' : { " + b.join("") + " } "); return e
        }, nb: function (a, b) { for (var d = 0; d < a.length; d++) if (r.a.v(a[d].key) == b) return !0; return !1 } 
        }
    } (); r.b("ko.jsonExpressionRewriting", r.i); r.b("ko.jsonExpressionRewriting.bindingRewriteValidators", r.i.B); r.b("ko.jsonExpressionRewriting.parseObjectLiteral", r.i.W); r.b("ko.jsonExpressionRewriting.insertPropertyAccessorsIntoJson", r.i.ia);
    (function () {
        function b(a) { return a.nodeType == 8 && a.nodeValue.match(d) } function e(d) { for (var e = d, h = 1, j = []; e = e.nextSibling; ) { if (e.nodeType == 8 && e.nodeValue.match(a) && (h--, h === 0)) return j; j.push(e); b(e) && h++ } c(Error("Cannot find closing comment tag to match: " + d.nodeValue)) } var d = /^\s*ko\s+(.*\:.*)\s*$/, a = /^\s*\/ko\s*$/; r.f = { C: {}, childNodes: function (a) { return b(a) ? e(a) : a.childNodes }, ha: function (a) { if (b(a)) for (var a = r.f.childNodes(a), d = 0, e = a.length; d < e; d++) r.removeNode(a[d]); else r.a.L(a) }, pa: function (a,
d) { if (b(a)) { r.f.ha(a); for (var e = a.nextSibling, j = 0, i = d.length; j < i; j++) e.parentNode.insertBefore(d[j], e) } else r.a.pa(a, d) }, tb: function (a, d) { b(a) ? a.parentNode.insertBefore(d, a.nextSibling) : a.firstChild ? a.insertBefore(d, a.firstChild) : a.appendChild(d) }, jb: function (a, d, e) { b(a) ? a.parentNode.insertBefore(d, e.nextSibling) : e.nextSibling ? a.insertBefore(d, e.nextSibling) : a.appendChild(d) }, nextSibling: function (d) {
    if (b(d)) var g = e(d), d = (g.length > 0 ? g[g.length - 1].nextSibling : d.nextSibling).nextSibling; else d = d.nextSibling &&
d.nextSibling.nodeType == 8 && d.nextSibling.nodeValue.match(a) ? l : d.nextSibling; return d
}, ua: function (a) { return (a = b(a)) ? a[1] : o }, fb: function (a) { if (r.f.ua(a)) { var b; b = r.f.childNodes(a); for (var d = [], e = 0, i = b.length; e < i; e++) r.a.w.H(b[e]), d.push(r.a.outerHTML(b[e])); b = String.prototype.concat.apply("", d); r.f.ha(a); (new r.m.D(a)).text(b) } } 
        }
    })(); r.G = function () { };
    r.a.extend(r.G.prototype, { nodeHasBindings: function (b) { switch (b.nodeType) { case 1: return b.getAttribute("data-bind") != o; case 8: return r.f.ua(b) != o; default: return !1 } }, getBindings: function (b, e) { var d = this.getBindingsString(b, e); return d ? this.parseBindingsString(d, e) : o }, getBindingsString: function (b) { switch (b.nodeType) { case 1: return b.getAttribute("data-bind"); case 8: return r.f.ua(b); default: return o } }, parseBindingsString: function (b, e) {
        try {
            var d = e.$data, a = " { " + r.i.ia(b) + " } "; return r.a.eb(a, d === o ? window :
d, e)
        } catch (f) { c(Error("Unable to parse bindings.\nMessage: " + f + ";\nBindings value: " + b)) } 
    } 
    }); r.G.instance = new r.G; r.b("ko.bindingProvider", r.G);
    (function () {
        function b(d, a, f) { var g = !0, h = a.nodeType == 1; if (h && f || r.G.instance.nodeHasBindings(a)) g = e(a, o, d, f).yb; if (h && g) for (f = a.childNodes[0]; a = f; ) f = r.f.nextSibling(a), b(d, a, !1) } function e(b, a, e, g) {
            function h(a) { return function () { return k[a] } } function j() { return k } var i = !0; r.f.fb(b); var k, m; new r.h(function () {
                var q = e && e instanceof r.F ? e : new r.F(r.a.d(e)), p = q.$data; g && r.La(b, q); if (k = (typeof a == "function" ? a() : a) || r.G.instance.getBindings(b, q)) {
                    if (i) for (var n in k) {
                        var s = r.c[n]; s && b.nodeType === 8 && !r.f.C[n] &&
c(Error("The binding '" + n + "' cannot be used with virtual elements")); if (s && typeof s.init == "function" && (s = (0, s.init)(b, h(n), j, p, q)) && s.controlsDescendantBindings) m !== l && c(Error("Multiple bindings (" + m + " and " + n + ") are trying to control descendant bindings of the same element. You cannot use these bindings together on the same element.")), m = n
                    } for (n in k) (s = r.c[n]) && typeof s.update == "function" && (0, s.update)(b, h(n), j, p, q)
                } 
            }, o, { disposeWhenNodeIsRemoved: b }); i = !1; return { yb: m === l}
        } r.c = {}; r.F = function (b, a) {
            this.$data =
b; a ? (this.$parent = a.$data, this.$parents = (a.$parents || []).slice(0), this.$parents.unshift(this.$parent), this.$root = a.$root) : (this.$parents = [], this.$root = b)
        }; r.F.prototype = { ea: function (b) { return new r.F(b, this) } }; r.La = function (b, a) { if (arguments.length == 2) r.a.e.set(b, "__ko_bindingContext__", a); else return r.a.e.get(b, "__ko_bindingContext__") }; r.ya = function (b, a, f) { return e(b, a, f, !0) }; r.xa = function (d, a) {
            a && a.nodeType !== 1 && a.nodeType !== 8 && c(Error("ko.applyBindings: first parameter should be your view model; second parameter should be a DOM node"));
            a = a || window.document.body; b(d, a, !0)
        }; r.da = function (b) { switch (b.nodeType) { case 1: case 8: var a = r.La(b); if (a) return a; if (b.parentNode) return r.da(b.parentNode) } }; r.Xa = function (b) { return (b = r.da(b)) ? b.$data : l }; r.b("ko.bindingHandlers", r.c); r.b("ko.applyBindings", r.xa); r.b("ko.applyBindingsToNode", r.ya); r.b("ko.contextFor", r.da); r.b("ko.dataFor", r.Xa)
    })(); r.a.p(["click"], function (b) { r.c[b] = { init: function (e, d, a, f) { return r.c.event.init.call(this, e, function () { var a = {}; a[b] = d(); return a }, a, f) } } });
    r.c.event = { init: function (b, e, d, a) { var f = e() || {}, g; for (g in f) (function () { var f = g; typeof f == "string" && r.a.s(b, f, function (b) { var g, k = e()[f], m = d(); try { g = k.apply(a, arguments) } finally { if (g !== !0) b.preventDefault ? b.preventDefault() : b.returnValue = !1 } if (m[f + "Bubble"] === !1) b.cancelBubble = !0, b.stopPropagation && b.stopPropagation() }) })() } };
    r.c.submit = { init: function (b, e, d, a) { typeof e() != "function" && c(Error("The value for a submit binding must be a function to invoke on submit")); r.a.s(b, "submit", function (d) { var g, h = e(); try { g = h.call(a, b) } finally { if (g !== !0) d.preventDefault ? d.preventDefault() : d.returnValue = !1 } }) } }; r.c.visible = { update: function (b, e) { var d = r.a.d(e()), a = b.style.display != "none"; if (d && !a) b.style.display = ""; else if (!d && a) b.style.display = "none" } };
    r.c.enable = { update: function (b, e) { var d = r.a.d(e()); if (d && b.disabled) b.removeAttribute("disabled"); else if (!d && !b.disabled) b.disabled = !0 } }; r.c.disable = { update: function (b, e) { r.c.enable.update(b, function () { return !r.a.d(e()) }) } };
    r.c.value = { init: function (b, e, d) { var a = d().valueUpdate || "change", f = !1; r.a.zb(a, "after") && (f = !0, a = a.substring(5)); var g = f ? function (a) { setTimeout(a, 0) } : function (a) { a() }; r.a.s(b, a, function () { g(function () { var a = e(), f = r.j.r(b); r.M(a) ? a(f) : (a = d(), a._ko_property_writers && a._ko_property_writers.value && a._ko_property_writers.value(f)) }) }) }, update: function (b, e) {
        var d = r.a.d(e()), a = r.j.r(b), f = d != a; d === 0 && a !== 0 && a !== "0" && (f = !0); f && (a = function () { r.j.Z(b, d) }, a(), b.tagName == "SELECT" && setTimeout(a, 0)); b.tagName == "SELECT" &&
(a = r.j.r(b), a !== d && r.a.ta(b, "change"))
    } 
    };
    r.c.options = { update: function (b, e, d) {
        b.tagName != "SELECT" && c(Error("options binding applies only to SELECT elements")); var a = r.a.aa(r.a.$(b.childNodes, function (a) { return a.tagName && a.tagName == "OPTION" && a.selected }), function (a) { return r.j.r(a) || a.innerText || a.textContent }), f = b.scrollTop, g = r.a.d(e()); r.a.L(b); if (g) {
            var h = d(); typeof g.length != "number" && (g = [g]); if (h.optionsCaption) { var j = document.createElement("OPTION"); j.innerHTML = h.optionsCaption; r.j.Z(j, l); b.appendChild(j) } d = 0; for (e = g.length; d < e; d++) {
                var j =
document.createElement("OPTION"), i = typeof h.optionsValue == "string" ? g[d][h.optionsValue] : g[d], k = h.optionsText; optionText = typeof k == "function" ? k(g[d]) : typeof k == "string" ? g[d][k] : i; i = r.a.d(i); optionText = r.a.d(optionText); r.j.Z(j, i); j.innerHTML = optionText.toString(); b.appendChild(j)
            } g = b.getElementsByTagName("OPTION"); d = h = 0; for (e = g.length; d < e; d++) r.a.k(a, r.j.r(g[d])) >= 0 && (r.a.Ka(g[d], !0), h++); if (f) b.scrollTop = f
        } 
    } 
    }; r.c.options.na = "__ko.bindingHandlers.options.optionValueDomData__";
    r.c.selectedOptions = { Da: function (b) { for (var e = [], b = b.childNodes, d = 0, a = b.length; d < a; d++) { var f = b[d]; f.tagName == "OPTION" && f.selected && e.push(r.j.r(f)) } return e }, init: function (b, e, d) { r.a.s(b, "change", function () { var a = e(); r.M(a) ? a(r.c.selectedOptions.Da(this)) : (a = d(), a._ko_property_writers && a._ko_property_writers.value && a._ko_property_writers.value(r.c.selectedOptions.Da(this))) }) }, update: function (b, e) {
        b.tagName != "SELECT" && c(Error("values binding applies only to SELECT elements")); var d = r.a.d(e()); if (d &&
typeof d.length == "number") for (var a = b.childNodes, f = 0, g = a.length; f < g; f++) { var h = a[f]; h.tagName == "OPTION" && r.a.Ka(h, r.a.k(d, r.j.r(h)) >= 0) } 
    } 
    }; r.c.text = { update: function (b, e) { var d = r.a.d(e()); if (d === o || d === l) d = ""; typeof b.innerText == "string" ? b.innerText = d : b.textContent = d } }; r.c.html = { init: function () { return { controlsDescendantBindings: !0} }, update: function (b, e) { var d = r.a.d(e()); r.a.xb(b, d) } };
    r.c.css = { update: function (b, e) { var d = r.a.d(e() || {}), a; for (a in d) if (typeof a == "string") { var f = r.a.d(d[a]); r.a.Oa(b, a, f) } } }; r.c.style = { update: function (b, e) { var d = r.a.d(e() || {}), a; for (a in d) if (typeof a == "string") { var f = r.a.d(d[a]); b.style[a] = f || "" } } }; r.c.uniqueName = { init: function (b, e) { if (e()) b.name = "ko_unique_" + ++r.c.uniqueName.Wa, r.a.ja && b.mergeAttributes(document.createElement("<input name='" + b.name + "'/>"), !1) } }; r.c.uniqueName.Wa = 0;
    r.c.checked = { init: function (b, e, d) { r.a.s(b, "click", function () { var a; if (b.type == "checkbox") a = b.checked; else if (b.type == "radio" && b.checked) a = b.value; else return; var f = e(); b.type == "checkbox" && r.a.d(f) instanceof Array ? (a = r.a.k(r.a.d(f), b.value), b.checked && a < 0 ? f.push(b.value) : !b.checked && a >= 0 && f.splice(a, 1)) : r.M(f) ? f() !== a && f(a) : (f = d(), f._ko_property_writers && f._ko_property_writers.checked && f._ko_property_writers.checked(a)) }); b.type == "radio" && !b.name && r.c.uniqueName.init(b, function () { return !0 }) }, update: function (b,
e) { var d = r.a.d(e()); if (b.type == "checkbox") b.checked = d instanceof Array ? r.a.k(d, b.value) >= 0 : d, d && r.a.ja && b.mergeAttributes(document.createElement("<input type='checkbox' checked='checked' />"), !1); else if (b.type == "radio") b.checked = b.value == d, b.value == d && (r.a.ja || r.a.lb) && b.mergeAttributes(document.createElement("<input type='radio' checked='checked' />"), !1) } 
    };
    r.c.attr = { update: function (b, e) { var d = r.a.d(e()) || {}, a; for (a in d) if (typeof a == "string") { var f = r.a.d(d[a]); f === !1 || f === o || f === l ? b.removeAttribute(a) : b.setAttribute(a, f.toString()) } } };
    r.c.hasfocus = { init: function (b, e, d) { function a(a) { var b = e(); a != r.a.d(b) && (r.M(b) ? b(a) : (b = d(), b._ko_property_writers && b._ko_property_writers.hasfocus && b._ko_property_writers.hasfocus(a))) } r.a.s(b, "focus", function () { a(!0) }); r.a.s(b, "focusin", function () { a(!0) }); r.a.s(b, "blur", function () { a(!1) }); r.a.s(b, "focusout", function () { a(!1) }) }, update: function (b, e) { var d = r.a.d(e()); d ? b.focus() : b.blur(); r.a.ta(b, d ? "focusin" : "focusout") } };
    r.c["with"] = { n: function (b) { return function () { var e = b(); return { "if": e, data: e, templateEngine: r.o.I} } }, init: function (b, e) { return r.c.template.init(b, r.c["with"].n(e)) }, update: function (b, e, d, a, f) { return r.c.template.update(b, r.c["with"].n(e), d, a, f) } }; r.i.B["with"] = !1; r.f.C["with"] = !0;
    r.c["if"] = { n: function (b) { return function () { return { "if": b(), templateEngine: r.o.I} } }, init: function (b, e) { return r.c.template.init(b, r.c["if"].n(e)) }, update: function (b, e, d, a, f) { return r.c.template.update(b, r.c["if"].n(e), d, a, f) } }; r.i.B["if"] = !1; r.f.C["if"] = !0; r.c.ifnot = { n: function (b) { return function () { return { ifnot: b(), templateEngine: r.o.I} } }, init: function (b, e) { return r.c.template.init(b, r.c.ifnot.n(e)) }, update: function (b, e, d, a, f) { return r.c.template.update(b, r.c.ifnot.n(e), d, a, f) } }; r.i.B.ifnot = !1;
    r.f.C.ifnot = !0; r.c.foreach = { n: function (b) { return function () { var e = r.a.d(b()); return !e || typeof e.length == "number" ? { foreach: e, templateEngine: r.o.I} : { foreach: e.data, includeDestroyed: e.includeDestroyed, afterAdd: e.afterAdd, beforeRemove: e.beforeRemove, afterRender: e.afterRender, templateEngine: r.o.I} } }, init: function (b, e) { return r.c.template.init(b, r.c.foreach.n(e)) }, update: function (b, e, d, a, f) { return r.c.template.update(b, r.c.foreach.n(e), d, a, f) } }; r.i.B.foreach = !1; r.f.C.foreach = !0; r.t = function () { };
    r.t.prototype.renderTemplateSource = function () { c("Override renderTemplateSource in your ko.templateEngine subclass") }; r.t.prototype.createJavaScriptEvaluatorBlock = function () { c("Override createJavaScriptEvaluatorBlock in your ko.templateEngine subclass") };
    r.t.prototype.makeTemplateSource = function (b) { if (typeof b == "string") { var e = document.getElementById(b); e || c(Error("Cannot find template with ID " + b)); return new r.m.g(e) } else if (b.nodeType == 1 || b.nodeType == 8) return new r.m.D(b); else c(Error("Unrecognised template type: " + b)) }; r.t.prototype.renderTemplate = function (b, e, d) { return this.renderTemplateSource(this.makeTemplateSource(b), e, d) }; r.t.prototype.isTemplateRewritten = function (b) { return this.allowTemplateRewriting === !1 ? !0 : this.U && this.U[b] ? !0 : this.makeTemplateSource(b).data("isRewritten") };
    r.t.prototype.rewriteTemplate = function (b, e) { var d = this.makeTemplateSource(b), a = e(d.text()); d.text(a); d.data("isRewritten", !0); if (typeof b == "string") this.U = this.U || {}, this.U[b] = !0 }; r.b("ko.templateEngine", r.t);
    r.X = function () {
        function b(a, b, d) { for (var a = r.i.W(a), e = r.i.B, j = 0; j < a.length; j++) { var i = a[j].key; if (e.hasOwnProperty(i)) { var k = e[i]; typeof k === "function" ? (i = k(a[j].value)) && c(Error(i)) : k || c(Error("This template engine does not support the '" + i + "' binding within its templates")) } } a = "ko.templateRewriting.applyMemoizedBindingsToNextSibling(function() {             return (function() { return { " + r.i.ia(a) + " } })()         })"; return d.createJavaScriptEvaluatorBlock(a) + b } var e = /(<[a-z]+\d*(\s+(?!data-bind=)[a-z0-9\-]+(=(\"[^\"]*\"|\'[^\']*\'))?)*\s+)data-bind=(["'])([\s\S]*?)\5/gi,
d = /<\!--\s*ko\b\s*([\s\S]*?)\s*--\>/g; return { cb: function (a, b) { b.isTemplateRewritten(a) || b.rewriteTemplate(a, function (a) { return r.X.qb(a, b) }) }, qb: function (a, f) { return a.replace(e, function (a, d, e, i, k, m, q) { return b(q, d, f) }).replace(d, function (a, d) { return b(d, "<\!-- ko --\>", f) }) }, Ra: function (a) { return r.q.ma(function (b, d) { b.nextSibling && r.ya(b.nextSibling, a, d) }) } }
    } (); r.b("ko.templateRewriting", r.X); r.b("ko.templateRewriting.applyMemoizedBindingsToNextSibling", r.X.Ra);
    (function () {
        r.m = {}; r.m.g = function (b) { this.g = b }; r.m.g.prototype.text = function () { if (arguments.length == 0) return this.g.tagName.toLowerCase() == "script" ? this.g.text : this.g.innerHTML; else { var b = arguments[0]; this.g.tagName.toLowerCase() == "script" ? this.g.text = b : this.g.innerHTML = b } }; r.m.g.prototype.data = function (b) { if (arguments.length === 1) return r.a.e.get(this.g, "templateSourceData_" + b); else r.a.e.set(this.g, "templateSourceData_" + b, arguments[1]) }; r.m.D = function (b) { this.g = b }; r.m.D.prototype = new r.m.g; r.m.D.prototype.text =
function () { if (arguments.length == 0) return r.a.e.get(this.g, "__ko_anon_template__"); else r.a.e.set(this.g, "__ko_anon_template__", arguments[0]) }; r.b("ko.templateSources", r.m); r.b("ko.templateSources.domElement", r.m.g); r.b("ko.templateSources.anonymousTemplate", r.m.D)
    })();
    (function () {
        function b(a, b, d) { for (var e = 0; node = a[e]; e++) node.parentNode === b && (node.nodeType === 1 || node.nodeType === 8) && d(node) } function e(a, b, e, h, j) {
            var j = j || {}, i = j.templateEngine || d; r.X.cb(e, i); e = i.renderTemplate(e, h, j); (typeof e.length != "number" || e.length > 0 && typeof e[0].nodeType != "number") && c("Template engine must return an array of DOM nodes"); i = !1; switch (b) {
                case "replaceChildren": r.f.pa(a, e); i = !0; break; case "replaceNode": r.a.Ia(a, e); i = !0; break; case "ignoreTargetNode": break; default: c(Error("Unknown renderMode: " +
b))
            } i && (r.va(e, h), j.afterRender && j.afterRender(e, h.$data)); return e
        } var d; r.qa = function (a) { a != l && !(a instanceof r.t) && c("templateEngine must inherit from ko.templateEngine"); d = a }; r.va = function (a, d) { var e = r.a.J([], a), h = a.length > 0 ? a[0].parentNode : o; b(e, h, function (a) { r.xa(d, a) }); b(e, h, function (a) { r.q.Qa(a, [d]) }) }; r.oa = function (a, b, g, h, j) {
            g = g || {}; (g.templateEngine || d) == l && c("Set a template engine before calling renderTemplate"); j = j || "replaceChildren"; if (h) {
                var i = h.nodeType ? h : h.length > 0 ? h[0] : o; return new r.h(function () {
                    var d =
b && b instanceof r.F ? b : new r.F(r.a.d(b)), m = typeof a == "function" ? a(d.$data) : a, d = e(h, j, m, d, g); j == "replaceNode" && (h = d, i = h.nodeType ? h : h.length > 0 ? h[0] : o)
                }, o, { disposeWhen: function () { return !i || !r.a.ga(i) }, disposeWhenNodeIsRemoved: i && j == "replaceNode" ? i.parentNode : i })
            } else return r.q.ma(function (d) { r.oa(a, b, g, d, "replaceNode") })
        }; r.wb = function (a, b, d, h, j) {
            function i(a, b) { var e = j.ea(r.a.d(a)); r.va(b, e); d.afterRender && d.afterRender(b, e.$data) } return new r.h(function () {
                var k = r.a.d(b) || []; typeof k.length == "undefined" &&
(k = [k]); k = r.a.$(k, function (a) { return d.includeDestroyed || !a._destroy }); r.a.Ja(h, k, function (b) { var f = typeof a == "function" ? a(b) : a; return e(o, "ignoreTargetNode", f, j.ea(r.a.d(b)), d) }, d, i)
            }, o, { disposeWhenNodeIsRemoved: h })
        }; r.c.template = { init: function (a, b) { var d = r.a.d(b()); typeof d != "string" && !d.name && a.nodeType == 1 && ((new r.m.D(a)).text(a.innerHTML), r.a.L(a)); return { controlsDescendantBindings: !0} }, update: function (a, b, d, e, j) {
            b = r.a.d(b()); e = !0; typeof b == "string" ? d = b : (d = b.name, "if" in b && (e = e && r.a.d(b["if"])),
"ifnot" in b && (e = e && !r.a.d(b.ifnot))); var i = o; typeof b.foreach != "undefined" ? i = r.wb(d || a, e && b.foreach || [], b, a, j) : e ? (j = typeof b == "object" && "data" in b ? j.ea(r.a.d(b.data)) : j, i = r.oa(d || a, j, b, a)) : r.f.ha(a); j = i; (b = r.a.e.get(a, "__ko__templateSubscriptionDomDataKey__")) && typeof b.u == "function" && b.u(); r.a.e.set(a, "__ko__templateSubscriptionDomDataKey__", j)
        } 
        }; r.i.B.template = function (a) { a = r.i.W(a); return a.length == 1 && a[0].unknown ? o : r.i.nb(a, "name") ? o : "This template engine does not support anonymous templates nested within its templates" };
        r.f.C.template = !0
    })(); r.b("ko.setTemplateEngine", r.qa); r.b("ko.renderTemplate", r.oa);
    r.a.K = function (b, e, d) {
        if (d === l) return r.a.K(b, e, 1) || r.a.K(b, e, 10) || r.a.K(b, e, Number.MAX_VALUE); else {
            for (var b = b || [], e = e || [], a = b, f = e, g = [], h = 0; h <= f.length; h++) g[h] = []; for (var h = 0, j = Math.min(a.length, d); h <= j; h++) g[0][h] = h; h = 1; for (j = Math.min(f.length, d); h <= j; h++) g[h][0] = h; for (var j = a.length, i, k = f.length, h = 1; h <= j; h++) { i = Math.max(1, h - d); for (var m = Math.min(k, h + d); i <= m; i++) g[i][h] = a[h - 1] === f[i - 1] ? g[i - 1][h - 1] : Math.min(g[i - 1][h] === l ? Number.MAX_VALUE : g[i - 1][h] + 1, g[i][h - 1] === l ? Number.MAX_VALUE : g[i][h - 1] + 1) } d =
b.length; a = e.length; f = []; h = g[a][d]; if (h === l) g = o; else { for (; d > 0 || a > 0; ) { j = g[a][d]; k = a > 0 ? g[a - 1][d] : h + 1; m = d > 0 ? g[a][d - 1] : h + 1; i = a > 0 && d > 0 ? g[a - 1][d - 1] : h + 1; if (k === l || k < j - 1) k = h + 1; if (m === l || m < j - 1) m = h + 1; i < j - 1 && (i = h + 1); k <= m && k < i ? (f.push({ status: "added", value: e[a - 1] }), a--) : (m < k && m < i ? f.push({ status: "deleted", value: b[d - 1] }) : (f.push({ status: "retained", value: b[d - 1] }), a--), d--) } g = f.reverse() } return g
        } 
    }; r.b("ko.utils.compareArrays", r.a.K);
    (function () {
        function b(b, d, a, f) { var g = [], b = r.h(function () { var b = d(a) || []; g.length > 0 && (r.a.Ia(g, b), f && f(a, b)); g.splice(0, g.length); r.a.J(g, b) }, o, { disposeWhenNodeIsRemoved: b, disposeWhen: function () { return g.length == 0 || !r.a.ga(g[0]) } }); return { ob: g, h: b} } r.a.Ja = function (e, d, a, f, g) {
            for (var d = d || [], f = f || {}, h = r.a.e.get(e, "setDomNodeChildrenFromArrayMapping_lastMappingResult") === l, j = r.a.e.get(e, "setDomNodeChildrenFromArrayMapping_lastMappingResult") || [], i = r.a.aa(j, function (a) { return a.Sa }), k = r.a.K(i, d), d = [],
m = 0, q = [], i = [], p = o, n = 0, s = k.length; n < s; n++) switch (k[n].status) { case "retained": var t = j[m]; d.push(t); t.S.length > 0 && (p = t.S[t.S.length - 1]); m++; break; case "deleted": j[m].h.u(); r.a.p(j[m].S, function (a) { q.push({ element: a, index: n, value: k[n].value }); p = a }); m++; break; case "added": var t = k[n].value, u = b(e, a, t, g), v = u.ob; d.push({ Sa: k[n].value, S: v, h: u.h }); for (var u = 0, z = v.length; u < z; u++) { var w = v[u]; i.push({ element: w, index: n, value: k[n].value }); p == o ? r.f.tb(e, w) : r.f.jb(e, w, p); p = w } g && g(t, v) } r.a.p(q, function (a) { r.H(a.element) });
            a = !1; if (!h) { if (f.afterAdd) for (n = 0; n < i.length; n++) f.afterAdd(i[n].element, i[n].index, i[n].value); if (f.beforeRemove) { for (n = 0; n < q.length; n++) f.beforeRemove(q[n].element, q[n].index, q[n].value); a = !0 } } a || r.a.p(q, function (a) { r.removeNode(a.element) }); r.a.e.set(e, "setDomNodeChildrenFromArrayMapping_lastMappingResult", d)
        } 
    })(); r.b("ko.utils.setDomNodeChildrenFromArrayMapping", r.a.Ja); r.o = function () { this.allowTemplateRewriting = !1 }; r.o.prototype = new r.t;
    r.o.prototype.renderTemplateSource = function (b) { b = b.text(); return r.a.V(b) }; r.o.I = new r.o; r.qa(r.o.I); r.b("ko.nativeTemplateEngine", r.o);
    (function () {
        r.ka = function () {
            var b = this.mb = function () { if (typeof jQuery == "undefined" || !jQuery.tmpl && !jQuery.render) return 0; try { if (jQuery.render) return 3; if (jQuery.tmpl.tag.tmpl.open.toString().indexOf("__") >= 0) return 2 } catch (a) { } return 1 } (); this.renderTemplateSource = function (a, d, g) {
                g = g || {}; b < 2 && c(Error("Your version of jQuery.tmpl is too old. Please upgrade to jQuery.tmpl 1.0.0pre or later.")); var h = a.data("precompiled"); h || (h = a.text() || "", h = "{{ko_with " + (b == 2 ? "$item" : "$ctx") + ".koBindingContext}}" +
h + "{{/ko_with}}", h = jQuery.template(o, h), a.data("precompiled", h)); a = [d.$data]; d = jQuery.extend({ koBindingContext: d }, g.templateOptions); g = h; b < 3 ? d = jQuery.tmpl(g, a, d) : (d = jQuery.render(g, a, d), d = jQuery(r.a.V(d))); d.appendTo(document.createElement("div")); jQuery.fragments = {}; return d
            }; this.createJavaScriptEvaluatorBlock = function (a) { return "{{ko_code ((function() { return " + a + " })()) }}" }; this.addTemplate = function (a, b) { document.write("<script type='text/html' id='" + a + "'>" + b + "<\/script>") }; if (b >= 2) {
                var d = b ==
2 ? "tmpl" : "tmplSettings"; jQuery[d].tag.ko_code = { open: "__.push($1 || '');" }; jQuery[d].tag.ko_with = { open: "with($1) {", close: "} "}
            } 
        }; r.ka.prototype = new r.t; var b = new r.ka; b.mb > 0 && r.qa(b); r.b("ko.jqueryTmplTemplateEngine", r.ka)
    })();
})(window);                  