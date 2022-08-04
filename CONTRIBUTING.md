# Contibuting to vscode-hare-highlighting

Unlike most projects in the hare ecosystem, this one is hosted on GitHub, and uses Pull Requests. Sad, I know.

## Release Procedure.

You probably wont need to do this, but it's notes for me.

## MS Visual Studio Code

[vscode docs](https://code.visualstudio.com/api/working-with-extensions/publishing-extension)

[You need a recent version of node](https://github.com/microsoft/vscode-vsce/issues/653).
Somehow Ubuntu 22.04 uses Node 12, which is to old. Welp use nvm.

```shell
nvm install 16
nvm use 16
npm install -g vsce
```

To publish, you need an azure dev-ops org. What a pain. This is accociated with your github, not personal MS, or uni MS. But it's also assiciated with your gmail. These gmail may also have a liked MS account, which is now linked with a github account.

Get some personal access tokens from (https://dev.azure.com/adotinthevoid/_usersSettings/tokens)

Don't inflate the privlages, because you'll need to save this. Set Scopes to Custom defined and choose the Marketplace > Manage scope

My Azure dev-ops org is https://dev.azure.com/adotinthevoid

Then get a VSCode publisher, which is differnt, mine is https://marketplace.visualstudio.com/manage/publishers/adotinthevoid

```
vsce login adotinthevoid
```

This will test the PAT, but not save it lmao.

AFAIKT, adotinthevoid is the publisher, not the dev-ops org, but it asks for a PAT from the dev-ops.


```shell
vsce package
zipinfo -1 ./hare-highlighting-*.vsix > contents.txt # Inspect package
git diff contents.txt # Ensure this is expected
```

## Eclipse OpenVSX.

https://github.com/eclipse/openvsx/wiki/Publishing-Extensions

Login to accounts.eclipse.org. Username is your github.

Log into https://open-vsx.org/ with GH account.

Get a OVSX Pat. Put it in env var `OVSX_PAT`

```shell
npm i -g ovsx
ovsx create-namespace adotinthevoid # Should be a 1 time affair
```