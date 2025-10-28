#!/usr/bin/env php
<?php

function main() {
    $n = intval(trim(fgets(STDIN)));
    list($a, $b) = array_map('intval', explode(' ', trim(fgets(STDIN))));

    $result = solve($n);
    echo $result . "\n";
}

function solve($n) {

}

main();
