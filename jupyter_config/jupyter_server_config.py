c = get_config()
c.ServerApp.default_url = '/tree'
c.ServerApp.open_browser = False
c.ServerApp.allow_origin = '*'
c.ServerApp.jpserver_extensions = {
    # "jupyterlab": False,
    "notebook": False,
    "nbclassic": True
}