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

    <style>
        body {
            background-color: #f9f9f9;
            padding: 30px;
        }
        .card {
            padding: 20px;
            max-width: 450px;
            margin: 0 auto;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            background-color: white;
        }
        label {
            font-weight: 600;
        }
        select.form-control {
            height: auto;
        }
        .btn-save {
            width: 100%;
        }
    </style>
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
</body>
</html>
