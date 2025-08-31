<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cities.aspx.cs" Inherits="MetroCityDemo.Cities" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Metro City Selector</title>
    <!-- Bootstrap CSS CDN for quick styling -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />    
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="Scripts/knockout-3.5.1.js"></script>
    <script src="Scripts/Cities.js"></script>
    <link href="Content/Cty.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <h4 class="mb-4 text-center">Metro City Selector</h4>
            <div class="form-group">
                <label for="citySelect">Select City:</label>
                <select id="citySelect" class="form-control" data-bind="options: cityList, optionsText: 'City', value: selectedCity, optionsCaption: 'Select a city'"></select>
            </div>

            <div class="form-group form-check">
                <input id="metroCheck" type="checkbox" class="form-check-input" data-bind="checked: isMetro" />
                <label class="form-check-label" for="metroCheck">Is Metro?</label>
            </div>

            <button type="button" class="btn btn-primary btn-save" data-bind="click: submitMetroStatus">Save</button>
        </div>
    </form>
    <div class="return-main-link-fixed">
        <a href="index.html" >Return to Main Page...</a>
    </div>
</body>
</html>
