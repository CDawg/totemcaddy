rm -rf /e/TotemCaddy
echo "Removing old /E/TotemCaddy"
cp -r "/c/Program Files (x86)/World of Warcraft/_anniversary_/Interface/AddOns/TotemCaddy" /e/TotemCaddy
echo "Copying over current TotemCaddy => /E/TotemCaddy"
rm /e/TotemCaddy/.gitignore
rm /e/TotemCaddy/package.sh
rm -rf /e/TotemCaddy/.vscode/
rm -rf /e/TotemCaddy/.git/
echo "Cleaned up the .git .vscode"
echo "Done!"
