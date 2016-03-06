# Vapor Assets: Stencil

Stencil additions for [Vapor Assets](https://github.com/shnhrrsn/vapor-assets)

### Installation

To add VaporAssetsStencil, add the following package to your Package.swift.


`Package.swift`

```swift
.Package(url: "https://github.com/shnhrrsn/vapor-assets-stencil.git", majorVersion: 0)
```

Next you’ll need modify your `main.swift` file to include the VaporAssetsStencil provider.  `VaporAssetsStencil.Provider` must be added _after_ `VaporStencil.Provider` and `VaporAssets.Provider`:

```swift
app.providers.append(VaporStencil.Provider)
app.providers.append(VaporAssets.Provider)
app.providers.append(VaporAssetsStencil.Provider)
```

## Usage

### Append Assets

```twig
{% asset scss app %}
{% asset coffee app %}
```

### Render Assets

```twig
{% assets styles %}
{% assets scripts %}
```

### Samples

`master.stencil`

```twig
<!DOCTYPE html>
<html>
	<head>
		{% block assets %}{% endblock %}
		{% assets styles %}
	</head>
	<body>
		{% block content %}{% endblock %}
		{% assets scripts %}
	</body>
</html>
```

`home.stencil`

```twig
{% extends "master.stencil" %}

{% block assets %}
	{% asset scss app %}
	{% asset coffee app %}
{% endblock %}

{% block content %}
	Hello!
{% endblock %}
```
