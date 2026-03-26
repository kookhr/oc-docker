const fs = require("node:fs");
const path = require("node:path");

const ROOT = "/app/dist";
const ANCHOR = 'const streamTo = params.streamTo === "parent" ? "parent" : void 0;';
const REPLACEMENT =
  'const streamTo = runtime === "acp" && params.streamTo === "parent" ? "parent" : void 0;';

function walk(dir) {
  const out = [];
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) out.push(...walk(full));
    else if (ent.isFile() && full.endsWith(".js")) out.push(full);
  }
  return out;
}

const files = walk(ROOT);
const hitFiles = [];
let hitSource = "";

for (const file of files) {
  let src;
  try {
    src = fs.readFileSync(file, "utf8");
  } catch {
    continue;
  }
  if (src.includes(ANCHOR)) {
    hitFiles.push(file);
    hitSource = src;
  }
}

if (hitFiles.length !== 1) {
  throw new Error(
    `Expected exactly 1 anchor file, found ${hitFiles.length}${
      hitFiles.length ? `: ${hitFiles.join(", ")}` : ""
    }`
  );
}

const file = hitFiles[0];
const matches = hitSource.split(ANCHOR).length - 1;
if (matches !== 1) {
  throw new Error(`Expected exactly 1 anchor match in ${file}, found ${matches}`);
}

const out = hitSource.replace(ANCHOR, REPLACEMENT);
if (out === hitSource) {
  throw new Error(`Patch made no changes in ${file}`);
}

fs.writeFileSync(file, out);
console.log("Patched", file);
