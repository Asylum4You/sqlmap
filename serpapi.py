from serpapi import GoogleSearch
import time
import random

def load_dorks(file_path):
    """Load dorks from a file."""
    with open(file_path, 'r') as file:
        dorks = [line.strip() for line in file if line.strip() and not line.startswith('#')]
    return dorks

def search_google(dork, api_key, num_results=5):
    """Search Google using a dork and return the results with SerpAPI."""
    targets = set()
    try:
        search = GoogleSearch({
            "q": dork,
            "api_key": api_key,
            "num": num_results,
            "hl": "en",
            "gl": "us"
        })
        result = search.get_dict()
        for search_result in result.get('organic_results', []):
            targets.add(search_result.get('link'))
    except Exception as e:
        print(f"Error during search for dork '{dork}': {e}")
    return targets

def main():
    dorks_file = 'ecommerce_dorks.txt'
    output_file = 'targets.txt'
    api_key = '9a6d62363898a09b21050c9c4b1cd06e66050bec2d312d6dddda812d0d00106b'  # Replace with your SerpAPI key

    dorks = load_dorks(dorks_file)
    all_targets = set()

    for dork in dorks:
        print(f"Searching Google with dork: {dork}")
        targets = search_google(dork, api_key)
        all_targets.update(targets)
        time.sleep(random.uniform(2, 5))  # Random delay between dorks

    # Save all potential targets
    with open(output_file, 'w') as f:
        for target in all_targets:
            f.write(target + '\n')

    print(f"Found {len(all_targets)} potential targets. Saved to {output_file}")

if __name__ == "__main__":
    main()