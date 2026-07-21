_ : {
	den.aspects.nvim.homeManager = { pkgs, lib, opts, ... }: {
		programs.neovim = {
			enable = true;

			extraPackages = with pkgs; [
				lua-language-server
				stylua
				tree-sitter

				nixd
				nil
				nixfmt
				statix
			];

			plugins = with pkgs.vimPlugins; [
				lazy-nvim
			];

			initLua = let treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;

			treesitterGrammars = pkgs.symlinkJoin {
				name = "nvim-treesitter-grammers";
				paths = treesitter.dependencies;
			};

			plugins = with pkgs.vimPlugins; [
          			blink-cmp
          			bufferline-nvim
          			conform-nvim
          			flash-nvim
          			friendly-snippets
          			fzf-lua
          			gitsigns-nvim
          			grug-far-nvim
          			lazydev-nvim
          			lazy-nvim
          			LazyVim
          			lualine-nvim
          			mini-ai
          			mini-icons
          			mini-pairs
          			neo-tree-nvim
          			noice-nvim
          			nui-nvim
          			nvim-lint
          			nvim-lspconfig
          			nvim-treesitter
          			nvim-treesitter-textobjects
          			nvim-ts-autotag
          			persistence-nvim
          			plenary-nvim
          			snacks-nvim
          			todo-comments-nvim
          			tokyonight-nvim
          			trouble-nvim
          			ts-comments-nvim
          			which-key-nvim

          			# When a plugin's name in nixpkgs doesn't match what Lazy expects,
          			# you can manually specify the mapping like this:
          			{
          			  name = "catppuccin";
          			  path = catppuccin-nvim;
          			}
			];

			mkEntryFromDrv =
				drv:
				if lib.isDerivation drv then
					{
						name = "${lib.getName drv}";
						path = drv;
					}
				else
					drv;
			
			lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
			in
			''
			local lsp_servers = {
			  lua_ls = {},
			  nixd = {},
			  nil_ls = {},
			}

			require("lazy").setup({
        		  defaults = {
        		    lazy = true,
        		  },
        		  dev = {
        		    -- reuse files from pkgs.vimPlugins.*
        		    path = "${lazyPath}",
        		    patterns = { "." },
        		    -- if a plugin isn't found in the linkFarm,
        		    -- Lazy will fall back to downloading it directly
        		    fallback = true,
        		  },
        		  spec = {
        		    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

        		    -- here you can enable extras like this:
        		    -- { import = "lazyvim.plugins.extras.editor.aerial" }, -- sybmols

        		    -- language specific config is often available via an extra
        		    -- find available languages here: https://www.lazyvim.org/extras or via :LazyExtras
        		    -- { import = "lazyvim.plugins.extras.lang.nix" }, -- configure lsp/formatters/treesitter etc. for nix 

        		    -- disable mason.nvim, use programs.neovim.extraPackages
        		    { "mason-org/mason-lspconfig.nvim", enabled = false },
        		    { "mason-org/mason.nvim", enabled = false },

        		    -- import/override with your plugins
        		    -- { import = "plugins" },

        		    -- since mason is disabled, each server needs to be explicitly
        		    -- configured here so nvim-lspconfig picks it up without mason
        		    { "neovim/nvim-lspconfig", opts = { servers = lsp_servers }},

        		    -- make sure nvim-treesitter is configured last,
        		    -- if you dont want to install all grammars you might
        		    -- need to use a function for ensure_installed to
        		    -- clear it
        		    {
        		      "nvim-treesitter/nvim-treesitter",
        		      -- dont run anything when installing/updating
        		      build = "",
        		      -- NOTE: when not all grammars are installed, make sure
        		      -- to clear encure_installed by making opts a function:
        		      -- opts = function(_, opts)
        		      --   opts.ensure_installed = {}
        		      --   opts.install_dir = "${treesitterGrammars}"
        		      --   return opts
        		      -- end,
        		      opts = {
        		        install_dir = "${treesitterGrammars}",
        		      },
        		    },
        		  },
        		  -- see https://www.lazyvim.org/plugins/colorscheme on how to change/install colorschemes 
        		  install = { colorscheme = { "habamax", "catppuccin" } },
        		  checker = { enabled = false }, -- disable automatic update checking
        		})
			'';
		};
	};
}
