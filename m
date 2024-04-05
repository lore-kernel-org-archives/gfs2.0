Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09E171E44
	for <gfs2@lists.linux.dev>; Fri,  5 Apr 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339198; cv=none; b=fM7KVmgpzjziYhyUux5AobqxEeC854c8Qu5O+9eAbv8MK/PDx2of0ICg5ERxG7oQs4bcmoE5YQxcGXCDNlduKvk6vr3GWC625S7ZqgB12ytbUzbAIPxXBG3qA4LGuFoleioAt1zpwfmru7OtBU3jx9L6Y+uzmbJAXPl9xs+mUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339198; c=relaxed/simple;
	bh=Wm0mo8vXdN1wzFCD7wJWuJkFZ/j7Ky+KnJ65ppXBp5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WhO6uu2QzMC3Akt0Xb7GIVzTvBzZR7imlAjG/7bJTrjHIcFOIVomwEB1NnA7G2xITGfqPfGG13FTNAyxivb/2kVh3HH4CYD0LwhQEJD0OSgu9K+I9StAn4pVoqeXl3xcYVagqLnGCMQBHxBty7kPbAW9cMRTp0yg9KYy8fZGibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9qdep1i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9qdep1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712339195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZGuClJGV6i73juVUdyhNxtuynVX+peFTFkaVD25mGnQ=;
	b=A9qdep1i6qi2pXhEmu4oObKM9l9G2g+aErtGnJz+J6Y1Qn+5AJE6rfby6fs2NeJf5UnWtT
	f8RxJ13gSLZd1aPVWdbxJpI/w9jcgCjSC9AGDx1Cv5lCo/GKijsQw6Op4Q4Qlt7jwW76t5
	r752kP4lh9c5Bx/Q7XBm5MuIcbZthzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Zsh7Ar7COdOyu2E8MB-s7g-1; Fri, 05 Apr 2024 13:46:34 -0400
X-MC-Unique: Zsh7Ar7COdOyu2E8MB-s7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CD818A3D34
	for <gfs2@lists.linux.dev>; Fri,  5 Apr 2024 17:46:32 +0000 (UTC)
Received: from fs-i40c-03.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8455E2166AFE;
	Fri,  5 Apr 2024 17:46:32 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com
Subject: [PATCH dlm-tool] tool: ignore file header on lockdebug
Date: Fri,  5 Apr 2024 13:46:18 -0400
Message-ID: <20240405174618.2277289-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since kernel commit 5beebc1dda47 ("dlm: update format header reflect
current format") the headline of some debugfs entries was updated to the
current format so it is possible to lookup what - what is instead of
looking up the source code. As side effect there is now an ugly:

print_rsb error rv 2 line "rsb ptr nodeid first_lkid flags
!root_list_empty !recover_list_empty recover_locks_count len

in front of every lockdebug dump as dlm_tool parse everything (including
the file header). Afterwards the dump proceeds. This patch will ignore
the first line of lockdebug in dlm_tool that is not required for
lockdebug pretty printout.
---
 dlm_tool/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dlm_tool/main.c b/dlm_tool/main.c
index 2e6810d6..5878ebc5 100644
--- a/dlm_tool/main.c
+++ b/dlm_tool/main.c
@@ -1085,6 +1085,10 @@ static void do_lockdebug(char *name)
 	memset(&summary, 0, sizeof(struct summary));
 	memset(&info, 0, sizeof(struct rinfo));
 
+	/* skip file header */
+	if (!fgets(line, LOCK_LINE_MAX, file))
+		goto done;
+
 	while (fgets(line, LOCK_LINE_MAX, file)) {
 
 		if (old)
@@ -1114,6 +1118,7 @@ static void do_lockdebug(char *name)
  raw:
 		printf("%s", line);
 	}
+ done:
 	count_rinfo(&summary, &info);
 	clear_rinfo(&info);
 	printf("\n");
-- 
2.43.0

