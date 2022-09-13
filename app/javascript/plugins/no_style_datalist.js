$(document).on('turbolinks:load', () => {

let childsYears = document.getElementById("childs_years");
let childsYearsHelper = document.getElementById("childs_years_helper");
let childsMonths = document.getElementById("childs_months");
let childsMonthsHelper = document.getElementById("childs_months_helper");
let currentFocus = -1;




childsYears.onfocus = function () {
  childsYearsHelper.style.display = 'block';
};

for (let option of childsYearsHelper.options) {
  option.onclick = function () {
  childsYears.value = option.value;
  childsYearsHelper.style.display = 'none';
  }
};

childsYears.oninput = function() {
  currentFocus = -1;
  var text = childsYears.value.toUpperCase();

for (let option of childsYearsHelper.options) {
  if(option.value.toUpperCase().indexOf(text) > -1)
    {
      option.style.display = "block";
    }
  else
    {
      option.style.display = "none";
    }
  };
}

childsYears.onkeydown = function(e) {
  if(e.keyCode == 40){
    currentFocus++
    addActive(childsYearsHelper.options);
  }
  else if(e.keyCode == 38){
    currentFocus--
    addActive(childsYearsHelper.options);
  }
  else if(e.keyCode == 13){
    e.preventDefault();
      if (currentFocus > -1) {
        /*and simulate a click on the "active" item:*/
      if (childsYearsHelper.options) childsYearsHelper.options[currentFocus].click();
    }
  }
}

childsMonths.onfocus = function () {
  childsMonthsHelper.style.display = 'block';
  };

for (let option of childsMonthsHelper.options) {
    option.onclick = function () {
    childsMonths.value = option.value;
    childsMonthsHelper.style.display = 'none';
    }
};

childsMonths.oninput = function() {
  currentFocus = -1;
  var text = childsMonths.value.toUpperCase();

  for (let option of childsMonthsHelper.options) {
    if(option.value.toUpperCase().indexOf(text) > -1)
    {
      option.style.display = "block";
    }
    else
    {
      option.style.display = "none";
    }
 };
}

childsMonths.onkeydown = function(e) {
  if(e.keyCode == 40){
    currentFocus++
    addActive(childsMonthsHelper.options);
  }
  else if(e.keyCode == 38){
    currentFocus--
    addActive(childsMonthsHelper.options);
  }
  else if(e.keyCode == 13){
    e.preventDefault();
    if (currentFocus > -1) {
      /*and simulate a click on the "active" item:*/
    if (childsMonthsHelper.options) childsMonthsHelper.options[currentFocus].click();
    }
  }
}

function addActive(x) {
    if (!x) return false;
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    x[currentFocus].classList.add("active");
}

  function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("active");
    }
  }
})
