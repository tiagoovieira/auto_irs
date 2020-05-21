# auto_irs
PT: Preenchimento automático do Quadro 9 do Anexo G do IRS
EN: Autofill Table 9 of the Annex G of Portuguese IRS declaration

### What do you need?
* A CSV with all the transactions, purchase and sale of assets, with the format of the example provided
** Rename it as `quadro9.csv`
* A previously saved IRS declaration XML file
** Make a copy and rename it as `test.xml` 
* Of course, Ruby installed on your machine

### How to run?

```ruby main.rb```

## NOTE: After uploading the new XML file, you need to add an empty line on Table 9 and remove it, this is to re-calculate the tax
