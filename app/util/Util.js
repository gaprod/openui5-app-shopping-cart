jQuery.sap.declare("util.Util");
jQuery.sap.require("openui5.module.SheetAsModel");

util.Util = {

	parseIndex : function (sPath) {
		return sPath.match(/\d+/)[0];
	},

	updateModel: function(oView) {
		var sSheetsUrl = "1SiKydCaik4MXYBxDLErLKe2o7OhTyXrTUO_bxbu-bSY";

		openui5.module.SheetAsModel.parseSheets(sSheetsUrl, function(data) {
      		var oModel = new sap.ui.model.json.JSONModel();
      		oModel.setData(data);
      		oView.setModel(oModel);
      		sap.ui.getCore().byId("Shell").setBusy(false);
			sap.ui.getCore().getEventBus().publish("ninja.openui5.cart", "modelRefreshed", {});
      	});
	}

};