//
//  AssetsNode.swift
//  Vapor Assets Stencil
//
//  Created by Shaun Harrison on 3/6/16.
//

import Stencil

class AssetsNode: NodeType {
	let type: String

	class func parse(parser: TokenParser, token: Token) throws -> NodeType {
		let bits = token.components()

		guard bits.count == 2 else {
			throw TemplateSyntaxError("'assets' tag takes one arguments, the type of assets to render")
		}

		return AssetsNode(type: bits[1])
	}

	init(type: String) {
		self.type = type
	}

	func render(context: Context) throws -> String {
		guard let assets = context["__assets-\(self.type)"] as? AssetList else {
			return ""
		}

		var html = ""

		if self.type == "styles" {
			for asset in assets.assets {
				html += "<link href=\"\(asset)\" media=\"all\" rel=\"stylesheet\" />"
			}
		} else if self.type == "scripts" {
			for asset in assets.assets {
				html += "<script src=\"\(asset)\" type=\"text/javascript\" />"
			}
		} else {
			throw TemplateSyntaxError("Invalid type for 'assets': \(self.type)")
		}

		return html
	}

}
