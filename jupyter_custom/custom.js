require(["base/js/namespace", "base/js/events"], function(Jupyter, events) {
    function addHomeButton() {
        const nav = document.querySelector(".nav.navbar-nav");
        if (!nav) return false;
        if (document.getElementById("home-button")) return true;

        const li = document.createElement("li");
        li.className = "dropdown";
        li.id = "home-button";

        const a = document.createElement("a");
        a.href = "javascript:history.back()";
        a.textContent = "Home";

        li.appendChild(a);
        nav.insertBefore(li, nav.firstChild);
        return true;
    }

    function fixLinks() {
        document.querySelectorAll("a.item_link[target='_blank']").forEach(function(link) {
            link.removeAttribute("target");
        });
    }

    function startObservers() {
        if (addHomeButton()) {
            fixLinks();
        }

        const observer = new MutationObserver(function() {
            addHomeButton();
            fixLinks();
        });

        if (document.body) {
            observer.observe(document.body, {
                childList: true,
                subtree: true
            });
        }
    }

    events.on("app_initialized.NotebookApp", startObservers);

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", startObservers);
    } else {
        startObservers();
    }
});