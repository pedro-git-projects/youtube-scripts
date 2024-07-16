#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

PROJECT_NAME=$1

echo "Creating a new Vite project named $PROJECT_NAME..."

npm create vite@latest $PROJECT_NAME -- --template vanilla

cd $PROJECT_NAME

echo "Installing base dependencies"

npm install

echo "Removing boilerplate"

rm -rf style.css counter.js javascript.svg

echo "Installing reveal"

npm install reveal.js

echo "Creating slides.md"

touch slides.md 

echo "Overriding main.js content"

cat <<EOL > main.js
import Reveal from 'reveal.js';
import Markdown from 'reveal.js/plugin/markdown/markdown.esm.js';

let deck = new Reveal({
  plugins: [Markdown],
});
deck.initialize();
EOL

echo "Overriding index.html content"

cat <<EOL > index.html
<!doctype html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8" />
  <link rel="icon" type="image/svg+xml" href="/vite.svg" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reveal Test</title>
  <link rel="stylesheet" href="node_modules/reveal.js/dist/reveal.css">
  <link rel="stylesheet" href="node_modules/reveal.js/dist/theme/black.css" id="theme">
</head>

<body>
  <div class="reveal">
    <div class="slides">
      <section data-markdown="slides.md"></section>
    </div>
  </div>
  <script type="module" src="/main.js"></script>
</body>

</html>
EOL

echo "Reveal project $PROJECT_NAME created successfully."
