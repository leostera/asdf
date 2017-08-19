"use strict";

(function(){

const $JSRTS = {
    throw: function (x) {
        throw x;
    },
    Lazy: function (e) {
        this.js_idris_lazy_calc = e;
        this.js_idris_lazy_val = void 0;
    },
    force: function (x) {
        if (x === undefined || x.js_idris_lazy_calc === undefined) {
            return x
        } else {
            if (x.js_idris_lazy_val === undefined) {
                x.js_idris_lazy_val = x.js_idris_lazy_calc()
            }
            return x.js_idris_lazy_val
        }
    },
    prim_strSubstr: function (offset, len, str) {
        return str.substr(Math.max(0, offset), Math.max(0, len))
    }
};
$JSRTS.prim_systemInfo = function (index) {
    switch (index) {
        case 0:
            return "javascript";
        case 1:
            return navigator.platform;
    }
    return "";
};
$JSRTS.prim_writeStr = function (x) { return console.log(x) }
$JSRTS.prim_readStr = function () { return prompt('Prelude.getLine') };



function $partial_5_6$io_95_bind(x1, x2, x3, x4, x5){
    return (function(x6){
        return io_95_bind(x1, x2, x3, x4, x5, x6);
    });
}

function $partial_3_4$io_95_pure(x1, x2, x3){
    return (function(x4){
        return io_95_pure(x1, x2, x3, x4);
    });
}

function $partial_1_2$Main__createElement(x1){
    return (function(x2){
        return Main__createElement(x1, x2);
    });
}

function $partial_1_2$Main__log(x1){
    return (function(x2){
        return Main__log(x1, x2);
    });
}

function $partial_1_2$Main__render(x1){
    return (function(x2){
        return Main__render(x1, x2);
    });
}

function $partial_0_1$Main___123_main_95_0_125_(){
    return (function(x1){
        return Main___123_main_95_0_125_(x1);
    });
}

function $partial_2_3$Main___123_setTimeout_95_0_125_(x1, x2){
    return (function(x3){
        return Main___123_setTimeout_95_0_125_(x1, x2, x3);
    });
}

function $partial_1_2$Main___123_main_95_1_125_(x1){
    return (function(x2){
        return Main___123_main_95_1_125_(x1, x2);
    });
}

function $partial_0_1$Main___123_setTimeout_95_1_125_(){
    return (function(x1){
        return Main___123_setTimeout_95_1_125_(x1);
    });
}

function $partial_0_1$Main___123_main_95_2_125_(){
    return (function(x1){
        return Main___123_main_95_2_125_(x1);
    });
}

function $partial_0_1$Main___123_main_95_3_125_(){
    return (function(x1){
        return Main___123_main_95_3_125_(x1);
    });
}

function $partial_0_1$Main___123_main_95_4_125_(){
    return (function(x1){
        return Main___123_main_95_4_125_(x1);
    });
}

function $partial_0_1$Main___123_main_95_5_125_(){
    return (function(x1){
        return Main___123_main_95_5_125_(x1);
    });
}

function $partial_0_1$Main___123_main_95_6_125_(){
    return (function(x1){
        return Main___123_main_95_6_125_(x1);
    });
}

function $partial_6_7$$_1_io_95_bind(x1, x2, x3, x4, x5, x6){
    return (function(x7){
        return $_1_io_95_bind(x1, x2, x3, x4, x5, x6, x7);
    });
}

const $HC_0_0$TheWorld = ({type: 0});
const $HC_0_0$Main__MkTimeout = ({type: 0});
// io_bind

function io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w){
    return $_2_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w)($_3_e(w));
}

// io_pure

function io_95_pure($_0_e, $_1_e, $_2_e, w){
    return $_2_e;
}

// Prelude.Monad.>>=

function Prelude__Monad___62__62__61_($_0_e, $_1_e, $_2_e, $_3_e){
    return $_1_e($_2_e)($_3_e);
}

// Main.createElement

function Main__createElement($_0_e, w){
    return (React.createElement(($_0_e), {}, ["Hello Wurld"]));
}

// Main.log

function Main__log(x, w){
    return (console.log((x)));
}

// Main.main

function Main__main(){
    return $partial_5_6$io_95_bind(null, null, null, Main__setTimeout($partial_0_1$Main___123_main_95_0_125_(), 1000), $partial_0_1$Main___123_main_95_6_125_());
}

// Main.render

function Main__render(x, w){
    return (ReactDOM.render((x), document.getElementById("root")));
}

// Main.setTimeout

function Main__setTimeout($_0_e, $_1_e){
    return $partial_5_6$io_95_bind(null, null, null, $partial_2_3$Main___123_setTimeout_95_0_125_($_0_e, $_1_e), $partial_0_1$Main___123_setTimeout_95_1_125_());
}

// Main.{main_0}

function Main___123_main_95_0_125_($_0_in){
    return $partial_1_2$Main__log("timed");
}

// Main.{setTimeout_0}

function Main___123_setTimeout_95_0_125_($_0_e, $_1_e, $_0_in){
    return (setTimeout(((function(x){
        return $_0_e(x)(null);
    })), ($_1_e)));
}

// Main.{main_1}

function Main___123_main_95_1_125_($_4_in, $_5_in){
    return $partial_5_6$io_95_bind(null, null, null, $_4_in, $_5_in);
}

// Main.{setTimeout_1}

function Main___123_setTimeout_95_1_125_($_1_in){
    return $partial_3_4$io_95_pure(null, null, $HC_0_0$Main__MkTimeout);
}

// Main.{main_2}

function Main___123_main_95_2_125_($_4_in){
    return $partial_1_2$Main___123_main_95_1_125_($_4_in);
}

// Main.{main_3}

function Main___123_main_95_3_125_($_3_in){
    return $partial_0_1$Main___123_main_95_2_125_();
}

// Main.{main_4}

function Main___123_main_95_4_125_($_2_in){
    return $partial_0_1$Main___123_main_95_3_125_();
}

// Main.{main_5}

function Main___123_main_95_5_125_($_6_in){
    return $partial_1_2$Main__render($_6_in);
}

// Main.{main_6}

function Main___123_main_95_6_125_($_1_in){
    return Prelude__Monad___62__62__61_(null, $partial_0_1$Main___123_main_95_4_125_(), null, null)($partial_1_2$Main__createElement("h1"))($partial_0_1$Main___123_main_95_5_125_());
}

// {io_bind_0}

function $_0_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w, $_0_in){
    return $_4_e($_0_in);
}

// {runMain_0}

function $_0_runMain(){
    return $JSRTS.force(Main__main()($HC_0_0$TheWorld));
}

// {io_bind_1}

function $_1_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w, $_0_in){
    return $_0_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w, $_0_in)(w);
}

// {io_bind_2}

function $_2_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w){
    return $partial_6_7$$_1_io_95_bind($_0_e, $_1_e, $_2_e, $_3_e, $_4_e, w);
}

$_0_runMain();
}.call(this))