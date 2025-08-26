$(function () {
    function MainViewModel() {
        var self = this;
        self.cityList = ko.observableArray([]);  // array of { City, IsMetro }
        self.selectedCity = ko.observable();
        self.isMetro = ko.observable(false);

        // Load cities with metro status
        $.ajax({
            type: "POST",
            url: "Cities.aspx/GetCities",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                self.cityList(response.d);
            }
        });

        // When city selected, update isMetro observable from local collection, no DB call
        self.selectedCity.subscribe(function (newCity) {
            if (!newCity.City) {
                self.isMetro(false);
                return;
            }
            // Find city object in cityList with City == newCity string
            var cityObj = self.cityList().find(function (c) {
                return c.City === newCity.City;
            });

            if (cityObj) {
                self.isMetro(cityObj.IsMetro);
            } else {
                self.isMetro(false);
            }
        });


        // Save metro status to DB and update local collection too
        self.submitMetroStatus = function () {
            if (!self.selectedCity()) {
                alert("Select a city first.");
                return;
            }
            $.ajax({
                type: "POST",
                url: "Cities.aspx/UpdateMetroStatus",
                data: JSON.stringify({
                    city: self.selectedCity().City,
                    isMetro: self.isMetro()
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) {
                        // Update local collection on success
                        var cityObj = self.cityList().find(c => c.City === self.selectedCity().City);
                        if (cityObj) {
                            cityObj.IsMetro = self.isMetro();
                            self.cityList.valueHasMutated(); // Notify KO about the change
                        }
                        alert("Saved successfully!");
                    } else {
                        alert("Update failed!");
                    }
                },
                error: function () {
                    alert("Error while saving data.");
                }
            });
        };
    }


    ko.applyBindings(new MainViewModel());
});
