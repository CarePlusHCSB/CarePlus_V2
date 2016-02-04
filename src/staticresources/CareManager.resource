<div class="tree" >
    <style>
 * {margin: 0; padding: 0;}

.tree ul {
    padding-top: 20px; position: relative;
    -transition: all 0.5s;
    -webkit-transition: all 0.5s;
    -moz-transition: all 0.5s;
}

.tree li {
    text-align: center;
    list-style-type: none;
    position: relative;
    padding: 20px 5px 0 5px;
    
    -transition: all 0.5s;
    -webkit-transition: all 0.5s;
    -moz-transition: all 0.5s;
}

/*We need to remove left-right connectors from elements without 
any siblings*/
.tree li:only-child::after, .tree li:only-child::before {
    display: none;
}


/*Adding back the vertical connector to the last nodes*/
.tree li:last-child::before{
    border-right: 1px solid #ccc;
    border-radius: 0 5px 0 0;
    -webkit-border-radius: 0 5px 0 0;
    -moz-border-radius: 0 5px 0 0;
}
.tree li:first-child::after{
    border-radius: 5px 0 0 0;
    -webkit-border-radius: 5px 0 0 0;
    -moz-border-radius: 5px 0 0 0;
}

/*Time to add downward connectors from parents*/
.tree ul:ul {
    content: '';
    position: absolute; top: 0; left: 50%;
    border-left: 1px solid #ccc;
    width: 0; height: 20px;
}


    ul li:before {
    /* lines */
    content:"";
    position: relative;
    border-left: 1px solid black;
    height: 30px;
    width: 1px;
}

.tree li {
    border: 3px solid #999933;
    padding: 5px 10px;
    text-decoration: none;
    color: #990066;
    font-family: arial, verdana, tahoma;
    font-size: 15px;
    display: block;
    width: 80px;
    height: 20px;
    margin: 1em;
    
     border-radius: 10px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    
    -transition: all 0.5s;
    -webkit-transition: all 0.5s;
    -moz-transition: all 0.5s;
}
</style>
