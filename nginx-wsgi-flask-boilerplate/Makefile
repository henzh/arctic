project = fake

dev-build:
	docker-compose -p $(project)-dev -f docker-compose.test.yaml build

prod-build:
	docker-compose -p $(project)-prod -f docker-compose.yaml build


dev-up:
	docker-compose -p $(project)-dev -f docker-compose.test.yaml up

prod-up:
	docker-compose -p $(project)-prod -f docker-compose.yaml up

pycache-clean:
	sudo find . -type f -name "*.py[co]" -delete
	sudo find . -type d -name "__pycache__" -exec rm -rv {} +
	sudo find . -type d -name ".pytest_cache" -exec rm -rv {} +
