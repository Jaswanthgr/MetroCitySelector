function CityModel(data) {
    this.City = data.City;
    this.IsMetro = ko.observable(data.IsMetro);
}

function MainViewModel() {
    var self = this;

    self.allCities = ko.observableArray([]);
    self.selectedCities = ko.observableArray([]);
    self.metroCities = ko.observableArray([]);
    self.nonMetroCities = ko.observableArray([]);
    self.pendingChanges = ko.observableArray([]); // Track cities with unsaved status change

    // Load cities
    $.ajax({
        type: "POST",
        url: "Cities.aspx/GetCities",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var mapped = response.d.map(item => new CityModel(item));
            self.allCities(mapped);
        }
    });

    self.toggleSelectCity = function (city) {
        if (self.selectedCities.indexOf(city) >= 0) {
            self.selectedCities.remove(city);
        } else {
            self.selectedCities.push(city);
        }
    };

    // Move selected cities to their category lists and remove from allCities
    self.moveSelectedToCategory = function () {
        if (self.selectedCities().length === 0) return;
        self.selectedCities().forEach(function (city) {
            self.allCities.remove(city);
            if (city.IsMetro()) {
                if (self.metroCities.indexOf(city) === -1) self.metroCities.push(city);
            } else {
                if (self.nonMetroCities.indexOf(city) === -1) self.nonMetroCities.push(city);
            }
        });
        self.selectedCities([]);
    };

    // Click on any city toggles status and marks it pending
    self.toggleMetroStatus = function (city) {
        var newStatus = !city.IsMetro();
        city.IsMetro(newStatus);
        if (newStatus) {
            self.nonMetroCities.remove(city);
            if (self.metroCities.indexOf(city) === -1) self.metroCities.push(city);
        } else {
            self.metroCities.remove(city);
            if (self.nonMetroCities.indexOf(city) === -1) self.nonMetroCities.push(city);
        }
        if (self.pendingChanges.indexOf(city) === -1) self.pendingChanges.push(city);
    };

    // For highlighting unsaved changes
    self.isPendingChange = function (city) {
        return self.pendingChanges.indexOf(city) !== -1;
    };

    // Save all pending changes
    self.savePendingChanges = function () {
        if (self.pendingChanges().length === 0) return;

        // Prepare updates array
        var updates = self.pendingChanges().map(function (city) {
            return { City: city.City, IsMetro: city.IsMetro() };
        });

        // Send all updates individually using existing API
        var updateCount = 0, total = updates.length;
        var errors = [];
        updates.forEach(function (cityUpdate) {
            $.ajax({
                type: "POST",
                url: "Cities.aspx/UpdateMetroStatus",
                data: JSON.stringify({ city: cityUpdate.City, isMetro: cityUpdate.IsMetro }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (!response.d) errors.push(cityUpdate.City);
                    updateCount++;
                    if (updateCount === total) {
                        if (errors.length === 0) {
                            alert("Changes saved!");
                            self.pendingChanges([]);
                        } else {
                            alert("Some updates failed: " + errors.join(", "));
                        }
                    }
                },
                error: function () {
                    errors.push(cityUpdate.City);
                    updateCount++;
                    if (updateCount === total) {
                        alert("Some updates failed: " + errors.join(", "));
                    }
                }
            });
        });
    };
}

$(function () {
    ko.applyBindings(new MainViewModel());
});
