// DevWeave Interactive Application JS

document.addEventListener("DOMContentLoaded", () => {
  initTabs();
  initCopyButtons();
  initCalculator();
  initRepoFilter();
});

// Platform Tab Switcher
function initTabs() {
  const tabBtns = document.querySelectorAll(".tab-btn");
  const tabPanes = document.querySelectorAll(".tab-pane");

  tabBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
      const targetId = btn.getAttribute("data-tab");

      tabBtns.forEach((b) => b.classList.remove("active"));
      tabPanes.forEach((p) => p.classList.remove("active"));

      btn.classList.add("active");
      const activePane = document.getElementById(targetId);
      if (activePane) {
        activePane.classList.add("active");
      }
    });
  });
}

// Copy Code Snippets
function initCopyButtons() {
  const copyBtns = document.querySelectorAll(".btn-copy");

  copyBtns.forEach((btn) => {
    btn.addEventListener("click", async () => {
      const codeBlock = btn.closest(".code-wrapper").querySelector("pre code") || btn.closest(".code-wrapper").querySelector("pre");
      if (!codeBlock) return;

      const text = codeBlock.innerText;
      try {
        await navigator.clipboard.writeText(text);
        const originalText = btn.innerText;
        btn.innerText = "Copied! ✓";
        btn.style.backgroundColor = "rgba(16, 185, 129, 0.4)";
        btn.style.color = "#34d399";

        setTimeout(() => {
          btn.innerText = originalText;
          btn.style.backgroundColor = "";
          btn.style.color = "";
        }, 2000);
      } catch (err) {
        console.error("Failed to copy text:", err);
      }
    });
  });
}

// Interactive ROI & Token Savings Calculator
function initCalculator() {
  const devsSlider = document.getElementById("slider-devs");
  const itemsSlider = document.getElementById("slider-items");
  const devsVal = document.getElementById("val-devs");
  const itemsVal = document.getElementById("val-items");

  const unstrTokensEl = document.getElementById("calc-unstr-tokens");
  const devweaveTokensEl = document.getElementById("calc-devweave-tokens");
  const tokenSavingsPctEl = document.getElementById("calc-token-savings-pct");
  const unstrCostEl = document.getElementById("calc-unstr-cost");
  const devweaveCostEl = document.getElementById("calc-devweave-cost");
  const netDollarSavingsEl = document.getElementById("calc-net-dollar-savings");
  const hoursSavedEl = document.getElementById("calc-hours-saved");

  function updateCalculations() {
    if (!devsSlider || !itemsSlider) return;

    const devs = parseInt(devsSlider.value, 10);
    const itemsPerMonth = parseInt(itemsSlider.value, 10);

    devsVal.innerText = devs.toLocaleString();
    itemsVal.innerText = itemsPerMonth.toLocaleString();

    const annualWorkItems = devs * itemsPerMonth * 12;

    // Averages based on weighted blend:
    // Unstructured avg per task: 575,000 tokens ($2.10 cost)
    // DevWeave avg per task: 64,400 tokens ($0.087 cost)
    const unstrTotalTokens = annualWorkItems * 575000;
    const devweaveTotalTokens = annualWorkItems * 64400;

    const unstrTotalCost = annualWorkItems * 2.10;
    const devweaveTotalCost = annualWorkItems * 0.087;

    const netSavings = unstrTotalCost - devweaveTotalCost;
    const tokenSavingsPct = ((1 - (devweaveTotalTokens / unstrTotalTokens)) * 100).toFixed(1);
    const hoursSaved = Math.round(annualWorkItems * 0.35); // 0.35 hrs rework saved per task

    unstrTokensEl.innerText = formatTokens(unstrTotalTokens);
    devweaveTokensEl.innerText = formatTokens(devweaveTotalTokens);
    tokenSavingsPctEl.innerText = `${tokenSavingsPct}% Savings`;
    unstrCostEl.innerText = formatCurrency(unstrTotalCost);
    devweaveCostEl.innerText = formatCurrency(devweaveTotalCost);
    netDollarSavingsEl.innerText = formatCurrency(netSavings);
    hoursSavedEl.innerText = `${hoursSaved.toLocaleString()} Hours`;
  }

  if (devsSlider && itemsSlider) {
    devsSlider.addEventListener("input", updateCalculations);
    itemsSlider.addEventListener("input", updateCalculations);
    updateCalculations();
  }
}

function formatTokens(num) {
  if (num >= 1e9) {
    return (num / 1e9).toFixed(1) + " Billion";
  } else if (num >= 1e6) {
    return (num / 1e6).toFixed(1) + " Million";
  }
  return num.toLocaleString();
}

function formatCurrency(num) {
  return "$" + num.toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

// 12-Repository Table Filter
function initRepoFilter() {
  const searchInput = document.getElementById("repo-search");
  const tableRows = document.querySelectorAll("#repo-table tbody tr");

  if (!searchInput || !tableRows.length) return;

  searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase();

    tableRows.forEach((row) => {
      const text = row.innerText.toLowerCase();
      if (text.includes(query)) {
        row.style.display = "";
      } else {
        row.style.display = "none";
      }
    });
  });
}
