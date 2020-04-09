function safeUsing(package::String)
    using Pkg
    installed = Pkg.installed()
    try
        installed[package]
    catch error
        Pkg.add(package)
    end
    Pkg.activate(package)
end
