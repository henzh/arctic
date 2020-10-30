project = fake

dev-build:
	docker-compose -p $(project)-dev -f docker-compose.test.yaml

prod-build:
	docker-compose build -p $(project)-prod -f docker-compose.yaml

dev-up:
	docker-compose up -p $(project)-dev -f docker-compose.test.yaml

prod-up:
	docker-compose up -p $(project)-prod -f docker-compose.yaml

pycache-clean:
	sudo find . -type f -name "*.py[co]" -delete
	sudo find . -type d -name "__pycache__" -exec rm -rv {} +
	sudo find . -type d -name ".pytest_cache" -exec rm -rv {} +
