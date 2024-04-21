





import pytest
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as E
from selenium.webdriver.common.action_chains import ActionChains
def test_basic_headless_selenium_example():
    """Test selenium installation by opening python website.
    (inspired by https://selenium-python.readthedocs.io/getting-started.html)
    """
    opts = Options()
    opts.headless = True
    driver = webdriver.Firefox(options=opts)
 
    driver.get("https://meteo-icd.surge.sh/")
    

    element = driver.find_element(By.CSS_SELECTOR, ".align-center > .v-btn")

    driver.find_element(By.CSS_SELECTOR, ".align-center > .v-btn").click()
    element = driver.find_element(By.CSS_SELECTOR, "body")

  
    driver.find_element(By.ID, "input-2").click()
    driver.find_element(By.ID, "input-2").send_keys("2023-03-22")
    driver.find_element(By.CSS_SELECTOR, ".justify-end").click()
    driver.find_element(By.ID, "input-2").click()
    driver.find_element(By.ID, "input-2").send_keys("2023-03-23")
    driver.find_element(By.CSS_SELECTOR, ".mdi-menu-down").click()
    driver.find_element(By.CSS_SELECTOR, ".v-list-item:nth-child(11)").click()
  
    driver.find_element(By.CSS_SELECTOR, ".bg-green").click()

