//
//  AssetNode.swift
//  Vapor Assets Stencil
//
//  Created by Shaun Harrison on 3/6/16.
//

import Stencil

class AssetNode: NodeType {
	let type: String
	let name: String

	class func parse(parser: TokenParser, token: Token) throws -> NodeType {
		let bits = token.components()

		guard bits.count == 3 else {
			throw TemplateSyntaxError("'asset' tag takes two arguments, the asset type and the asset name")
		}

		return AssetNode(type: bits[1], name: bits[2])
	}

	init(type: String, name: String) {
		self.type = type
		self.name = name
	}

	func render(context: Context) throws -> String {
		let tag: String
		let path: String

		switch self.type {
			case "style", "script":
				path = self.name
				tag = self.type + "s"
			case "styles", "scripts":
				path = self.name
				tag = self.type
			case "scss", "css":
				path = "/assets/\(self.type)/\(name).\(self.type)"
				tag = "styles"
			case "coffee", "js":
				path = "/assets/\(self.type)/\(name).\(self.type)"
				tag = "scripts"
			default:
				throw TemplateSyntaxError("Invalid type for 'asset': \(self.type)")
		}

		let key = "__assets-\(tag)"

		if context[key] == nil {
			context[key] = AssetList()
		}

		(context[key] as? AssetList)?.assets.append(path)

		return ""
	}

}
