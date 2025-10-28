#!/usr/bin/env node

function main(input) {
    const lines = input.trim().split('\n');
    const n = parseInt(lines[0]);
    const [a, b] = lines[1].split(' ').map(Number);

    const result = solve(n);
    console.log(result);
}

function solve(n) {

}

require('fs').readFile('/dev/stdin', 'utf8', (err, data) => {
    if (err) throw err;
    main(data);
});
