# Vim Cheatsheets

`[]` - denotes parameters
`<>` - denotes optional parameters

# List of Contents
- Native Motions and Keymaps
- Marks
- Search and Replace


# Native Motions and Keymaps

## Text Objects
Formula: `Operator + Inner/Around + Object`

| Objects | desc            |
| ------- | --------------- |
| w       | Word            |
| s       | Sentence        |
| p       | Paragraph       |
| b       | Parentheses     |
| B       | Curly Brackets  |
| [       | Square Brackets |
| <       | Angle Brackets  |
| ",',`   | Quotes          |


## `g` Motions

| keys | mode | desc                            |
| ---- | ---- | ------------------------------- |
| gv   | n    | Re-select last visual selection |


# Marks
NOTE: 
- Letters are for manual marks
- Numbers and Symbols are marks set by vim
- Marks can be used as motions for operators (ex. delete from cursor to the position of mark a)


## Basic Keybinds
| command                 | description                                        |
| ----------------------- | -------------------------------------------------- |
| m [letter]              | set a mark under the cursor (uppercase for global) |
| ' [character]           | jump to mark's line                                |
| ` [character]           | jump to mark's exact position                      |
| :marks                  | list all marks                                     |
| :delmarks <!/character> | delete all marks, or specified mark                |
Note: to delete all global marks, use A-Z as the parameters


## Automatic Marks
| mark | desc                                                 |
| ---- | ---------------------------------------------------- |
| `    | position before last jump                            |
| .    | position of last change                              |
| ^    | position of last insert mode exit                    |
| "    | position of last file close                          |
| 0-9  | Last neovim exit positions (from 1st [0] to 8th [9]) |



# Search and Replace
Basic structure: ` :[range]s/[pattern]/[replacement]/<flags> `
Note: 
- `/` can be replaced with other characters as the delimiters
- if pattern is blank, vim will use whatever is in **search register**
- use `\` as escape for reserved characters


## Ranges
| range         | desc                                                 |
| ------------- | ---------------------------------------------------- |
| %             | whole file                                           |
| .             | current line (default)                               |
| [num1],[num2] | lines num1 through num2                              |
| ' <,'>        | visual selection (those are not optional parameters) |
| .,+[num]      | current line + next num lines                        |


## Flags
| flag | desc                                                |
| ---- | --------------------------------------------------- |
| g    | replace all occurence in a line, not just the first |
| i    | case insensitive                                    |
| I    | case sensitive                                      |
| c    | confirm before each replacement                     |
| n    | reports number of matches (doesn't apply replace)   |
| e    | don't scream error on pattern not found             |


# Control Keys
The Control combinations cannot be shown by which-key, therefore a dedicated cheatsheet section is written for it.


| command                 | description         |
| ----------------------- | ------------------- |
| C-f -> in search prompt | open cmdline buffer |
