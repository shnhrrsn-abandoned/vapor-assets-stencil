//
//  Provider.swift
//  Vapor Assets Stencil
//
//  Created by Shaun Harrison on 3/6/16.
//

import Vapor
import VaporStencil

public class Provider: Vapor.Provider {

	public static func boot(application: Application) {
		guard let renderer = View.renderers[".stencil"] as? StencilRenderer else {
			Log.error("VaporAssetsStencil not loaded, VaporAssetsStencil.Provider must be added AFTER VaporStencil.Provider")
			return
		}

		renderer.namespace.registerTag("asset", parser: AssetNode.parse)
		renderer.namespace.registerTag("assets", parser: AssetsNode.parse)
	}

}
