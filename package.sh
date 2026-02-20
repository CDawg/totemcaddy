echo "Removing old /E/TotemCaddy"
rm -rf /e/TotemCaddy
rm -rf /e/TotemCaddy_GIT
echo "Copying over current TotemCaddy => /E/TotemCaddy"
cp -r "/c/Program Files (x86)/World of Warcraft/_anniversary_/Interface/AddOns/TotemCaddy" /e/TotemCaddy
echo "Copying over current TotemCaddy => /E/TotemCaddy_GIT"
cp -r "/c/Program Files (x86)/World of Warcraft/_anniversary_/Interface/AddOns/TotemCaddy" /e/TotemCaddy_GIT

echo "Cleaning up .git .vscode"
rm /e/TotemCaddy/.gitignore
rm /e/TotemCaddy/package.sh
rm -rf /e/TotemCaddy/.vscode/
rm -rf /e/TotemCaddy/.git/
echo "Done!"
