//Modified from: http://bootsnipp.com/snippets/featured/sidebar-navigation-with-scrollspy

/*Menu-toggle*/
$("#menu-toggle", ".dashboard").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("active");
});