<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CitiesCategorization.aspx.cs" Inherits="MetroCityDemo.CitiesCategorization" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Metro City Categorization</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="Scripts/knockout-3.5.1.js"></script>
    <script src="Scripts/CitiesCat.js"></script>
    <link href="Content/CtyCat.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container mt-4">
        <h4 class="mb-4 text-center">Metro City Categorization</h4>
        <div class="row">
            <div class="col-md-4">
                <label>All Cities (select one or more, click to select/deselect)</label>
                <ul data-bind="foreach: allCities" class="list-group all-cities-list" style="min-height: 200px;">
                    <li class="list-group-item list-group-item-action"
                        data-bind="text: City,
                                   css: { selected: $root.selectedCities.indexOf($data) >= 0 },
                                   click: function() { $root.toggleSelectCity($data); }"></li>
                </ul>
                <div class="d-flex gap-2 mt-2">
                    <button class="btn btn-primary" data-bind="click: moveSelectedToCategory, enable: selectedCities().length > 0">Categorize Selected</button>
                    <button type="button" class="btn btn-success" data-bind="click: savePendingChanges, enable: pendingChanges().length > 0">Save Changes</button>
                </div>
            </div>
            <div class="col-md-4">
            <label>Metro Cities (click to toggle)</label>
            <ul data-bind="foreach: metroCities" class="list-group metro-cities-list" style="min-height: 200px;">
                <li class="list-group-item list-group-item-action"
                    data-bind="text: City,
                               click: function() { $root.toggleMetroStatus($data); },
                               css: { 'pending-change': $root.isPendingChange($data) }"></li>
            </ul>
        </div>
        <div class="col-md-4">
            <label>Non-Metro Cities (click to toggle)</label>
            <ul data-bind="foreach: nonMetroCities" class="list-group nonmetro-cities-list" style="min-height: 200px;">
                <li class="list-group-item list-group-item-action"
                    data-bind="text: City,
                               click: function() { $root.toggleMetroStatus($data); },
                               css: { 'pending-change': $root.isPendingChange($data) }"></li>
            </ul>
        </div>
        </div>
    </form>
    <div class="return-main-link-fixed">
        <a href="Main.aspx" >Return to Main Page...</a>
    </div>
</body>
</html>
