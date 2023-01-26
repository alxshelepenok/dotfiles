from notion.client import NotionClient


def get_trash(c):
    query = {
        "type": "BlocksInSpace",
        "query": "",
        "filters": {
            "isDeletedOnly": True,
            "excludeTemplates": False,
            "isNavigableOnly": True,
            "requireEditPermissions": False,
            "ancestors": [],
            "createdBy": [],
            "editedBy": [],
            "lastEditedTime": {},
            "createdTime": {}
        },
        "sort": "Relevance",
        "limit": 1000,
        "spaceId": c.current_space.id,
        "source": "trash"
    }
    results = c.post('/api/v3/search', query)
    bi = results.json()['results']

    return [block_id['id'] for block_id in bi]


def chunks(lst, n):
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def delete_permanently(c, bi):
    for block_batch in chunks(bi, 10):
        try:
            c.post("deleteBlocks", {"blockIds": block_batch, "permanentlyDelete": True})
        except Exception as err:
            print(err)
            print(block_batch)


if __name__ == "__main__":
    token = input('Please enter your auth token: ')
    client = NotionClient(token_v2=token)

    block_ids = get_trash(client)
    delete_permanently(client, block_ids)
    print('Successfully cleared all trash blocks.')
