  var fieldEl = document.getElementById("filter-field");
  var typeEl = document.getElementById("filter-type");
  var valueEl = document.getElementById("filter-value");

  function customFilter(data){
    return data.car && data.rating < 3;
  }

  function updateFilter(){
  var filterVal = fieldEl.options[fieldEl.selectedIndex].value;
  var typeVal = typeEl.options[typeEl.selectedIndex].value;

  var filter = filterVal == "function" ? customFilter : filterVal;

  if(filterVal == "function" ){
    typeEl.disabled = true;
    valueEl.disabled = true;
  }else{
    typeEl.disabled = false;
    valueEl.disabled = false;
  }
  if(filterVal){
    table.setFilter(filter,typeVal, valueEl.value);

    if( $('input:radio[name=filtrxres]:checked').val() != "TODOS" ){

        table.addFilter("RESBUS", "like", $('input:radio[name=filtrxres]:checked').val());

    }

    console.log(filter)


  }
}

  var table = new Tabulator("#example-table", {
    ajaxURL:"/data", //ajax URL
    ajaxConfig:"GET", //ajax HTTP request type
    ajaxContentType:"json", // send parameters to the server as a JSON encoded string
    pagination:"local",
    groupBy:"RESBUS",
    groupStartOpen:false,
    paginationSize:100,
    layout:"fitDataStretch",
    paginationSizeSelector:[100, 500, 1000, 2000],
    columns:[
        {title:"Archivo", field:"ARCHIVO", sorter:"string", editor:false},
        {title:"Resultado", field:"RESBUS", sorter:"string", editor:false},
        {title:"MD5ORI", field:"MD5ORI", sorter:"string",editor:false},
        {title:"MD5DEST", field:"MD5DEST", sorter:"string", editor:false},
        {title:"TIPO", field:"TIPOARCH", sorter:"string", editor:false},
    ],
  });

  document.getElementById("filter-field").addEventListener("change", updateFilter);
  document.getElementById("filter-type").addEventListener("change", updateFilter);
  document.getElementById("filter-value").addEventListener("keyup", updateFilter);

  $("input[name=filtrxres]").click(function () {
    if( $('input:radio[name=filtrxres]:checked').val() == "TODOS" ){

        updateFilter();

    }
    else{
        //table.addFilter("RESBUS", "like", $('input:radio[name=filtrxres]:checked').val());
        updateFilter();
    }
  });



  document.getElementById("filter-clear").addEventListener("click", function(){

  fieldEl.value = "ARCHIVO";
  typeEl.value = "like";
  valueEl.value = "";

  table.clearFilter();
});