var currentRest = {};
var showForm = false;
var editingRest;

$(document).ready(function() {
  function toggle() {
    showForm = !showForm
    $("#rest-form").remove()
    $("#rests-list").toggle()

    if (showForm) {
      $.ajax({
        url: "/rest_form",
        method: "GET",
        data: {id: editingRest}
      }).done(function(html) {
        $("#toggle").after(html)
      })
    }
  }

  function getRest(id) {
    $.ajax({
      url: '/rests/' + id,
      method: 'GET'
    }).done( function(rest) {
      if (editingRest) {
        var li = $("[data-id='" + id + "'")
        $(li).replaceWith(rest)
        editingRest = null
      } else {
        $('#rests-list').append(rest);
      }
    });
  }

  $("#toggle").on("click", function() {
    toggle()
  })

  $(document).on("submit", "#rest-form form", function(e) {
    e.preventDefault()
    var data = $(this).serializeArray()
    var url = '/rests';
    var method = 'POST'
      if (editingRest) {
        url = url + '/' + editingRest;
        method = 'PUT'
      }
    $.ajax({
      url: "/rests",
      method: "POST",
      dataType: "JSON",
      data: data
    }).done(function(rest) {
      toggle()
      getRest(rest.id);
    }).fail(function(err) {
      alert(err.responseJSON.errors)
    })
  })

  $(document).on('click', '#edit-rest', function() {
    editingRest = $(this).siblings('.rest-item').data().id
    toggle();
  });

  $(document).on('click', '#delete-rest', function() {
    var id = $(this).siblings('.rest-item').data().id
    $.ajax({
      url: '/rests/' + id,
      method: 'DELETE'
    }).done( function() {
      var row = $("[data-id='" + id + "'")
      row.parent().remove('li');
    });
  });

  $(document).on("click", ".rest-item", function() {
    currentRest.id = this.dataset.id
    currentRest.name = this.dataset.name

    $.ajax({
      url: "/rests/" + currentRest.id + "/foods",
      method: "GET",
      dataType: "JSON"
    }).done(function(foods) {
      $("#rest").text("Menu of " + currentRest.name)
      var list = $("#foods");
      list.empty();
      foods.forEach(function(food) {
        var li = '<li data-food-id="' + food.id + '">' + food.dish + '-' + food.description + '</li>'
        list.append(li)
      })
    })
  })
})