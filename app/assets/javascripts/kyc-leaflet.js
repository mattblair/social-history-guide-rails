//var map = L.map('map').setView([45.518683, -122.681764], 14);

// see leaflet-providers repo at github for list of options
// https://github.com/leaflet-extras/leaflet-providers
// demo:
// http://leaflet-extras.github.io/leaflet-providers/
// A few options:
// Stamen.Watercolor
// OpenStreetMap.BlackAndWhite
// OpenStreetMap.Mapnik
// OpenStreetMap.DE
// Stamen.Toner
// Stamen.TonerLite

// launch website with: Stamen.Terrain
function addTilesToMap(tileSource, map) {
	
	L.tileLayer.provider(tileSource).addTo(map);
}

// based on http://leafletjs.com/examples/custom-icons.html
function addMarkerToMap(lat, lng, map) {
	
	// was redPin -- do we want a color?
	var thinPin = L.icon({
	    //iconUrl: 'http://kycstatic.elsewiseapps.com/assets/marker-icon.png',
		iconUrl: 'http://kycstatic.elsewiseapps.com/assets/kbb-thin-pin.png',
	    //shadowUrl: 'http://kycstatic.elsewiseapps.com/assets/marker-icon-shadow.png',
		shadowUrl: 'http://kycstatic.elsewiseapps.com/assets/empty-pin-shadow.png',

	    iconSize:     [15, 36], // actual size: 15, 56
	    shadowSize:   [10, 10], // was 50, 64
	    iconAnchor:   [7, 29], // point of the icon which will correspond to marker's location
	    shadowAnchor: [4, 62], // the same for the shadow
	    popupAnchor:  [1, -28] // point from which the popup should open relative to the iconAnchor
	});
	
	L.marker([lat, lng], {icon: thinPin}).addTo(map);
}

// from the mobile demo: 
// http://leafletjs.com/examples/mobile.html

function addUserToMap(map, moveToLocation) {
	
	map.locate({setView: moveToLocation, maxZoom: 14});

	function onLocationFound(e) {
	    var radius = e.accuracy / 2;

		// add .openPopup() to the end if you want to display the accuracy explicitly
	    L.marker(e.latlng).addTo(map)
	        .bindPopup("You are within " + radius + " meters from this point");

	    L.circle(e.latlng, radius).addTo(map);
	}

	map.on('locationfound', onLocationFound);

	function onLocationError(e) {
	    alert(e.message);
	}

	map.on('locationerror', onLocationError);
}

// from the geojson demo:
// http://leafletjs.com/examples/geojson.html

function addGeoJSONToMap(geojson, map) {

	function popupContent(title, link) {
	
		return "<a href=\"" + link + "\">" + title + "</a>"
	}

	// used for circle version of marker
	var geojsonMarkerOptions = {
	    radius: 8,
	    fillColor: "#ff0000",
	    color: "#000",
	    weight: 1,
	    opacity: 1,
	    fillOpacity: 0.7
	};
	
	// used for pin version of marker
	var thinPin = L.icon({
		iconUrl: 'http://kycstatic.elsewiseapps.com/assets/kbb-thin-pin.png',
		shadowUrl: 'http://kycstatic.elsewiseapps.com/assets/empty-pin-shadow.png',
	
	    iconSize:     [15, 36], // actual size: 15, 56
	    shadowSize:   [10, 10], // was 50, 64
	    iconAnchor:   [7, 29], // point of the icon which will correspond to marker's location
	    shadowAnchor: [4, 62],  // the same for the shadow
	    popupAnchor:  [1, -28] // point from which the popup should open relative to the iconAnchor
	});

	function onEachFeature(feature, layer) {
	    if (feature.properties && feature.properties.title && feature.properties.link) {
	        layer.bindPopup(popupContent(feature.properties.title, feature.properties.link));
	    }
	}
	
	L.geoJson(geojson, {
	    onEachFeature: onEachFeature,
		pointToLayer: function (feature, latlng) {
		        //return L.circleMarker(latlng, geojsonMarkerOptions);
				return L.marker(latlng, {icon: thinPin});
		    }
	}).addTo(map);
}