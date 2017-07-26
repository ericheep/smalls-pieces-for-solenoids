// untitled-3.ck
// (shake)

// July 26th, 2017
// Eric Heep

// init

0 => int test;

Meepo meep;
Utility u;
Listener l;
Gain g[3];

if (test) {
    adc => g[0] => dac;
    adc => l => blackhole;
    g[0].gain(0.0);
} else {
    adc.chan(0) => g[0] => dac.left;
    adc.chan(1) => g[1] => dac.left;
    adc.chan(2) => g[2] => dac.left;

    adc.chan(0) => l;
    adc.chan(1) => l;
    adc.chan(2) => l;
    l => blackhole;

    meep.init();
}

// guts

fun void magnetize(int idx, dur length) {
    now => time start;

    Math.random2(5, 6) => int velocity;
    Math.random2(6, 7)::ms => dur milliseconds;

    while (now < start + length) {
        meep.actuate(idx, velocity);
        milliseconds => now;
    }
}

fun void beeps() {
    [0, 1, 2] @=> int order[];
    u.shuffleArray(order);

    for (0 => int i; i < 3; i++) {
        spork ~ magnetize(order[i], 30::ms);

        70::ms => now;
    }
}

fun void main() {
    while (true) {
        beeps();
        .4::second => now;
    }
}

// run

second => now;
<<< "Okay.", "" >>>;

main();