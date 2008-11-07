// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function check(id)
{
  $(id).checked = true;
}

function uncheck(id)
{
  $(id).checked = false;
}

function toggle_check(id)
{
  $(id).checked = !$(id).checked;
}

function check_all(list)
{
  list.each(function (id) { check(id) });
}

function uncheck_all(list)
{
  list.each(function (id) { uncheck(id) });
}

function toggle_check_all(list)
{
  var first_unchecked = list.find(function (id) { return $(id).checked == false });
  if ( first_unchecked == undefined ) {
    uncheck_all(list);
  }
  else {
    check_all(list);
  }
}

