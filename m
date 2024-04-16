Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18D8664D
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262275; cv=none; b=MqOZiLQDjvWceB5BqACBxK48YxqDhbuAIb0N98h56wGM3RgtS7mz18ldTsnt3uqkDCzyDw9A9U2LOMOzRkCaY+vq22icWFlYlgZGs9h8HS1bEwoNooxo6Ov05R6lZ6IanMt79wPSzCaSCnlqjUullddAhkkfwBz4ibOXZUcruBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262275; c=relaxed/simple;
	bh=BHDD+6djjejZNLaxdznh0Fuh+9OSHLsnGQqZqE48uFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nktG37VSi9NW9KaF+EawkHGgAwBrmO2yJwqUeGnA7rbgfvxKlfnN1yBCXvN5Y5WrZs5Qq4tAngkqx6JQuiTrZ63ZHBxo7CnWJd8EAYdA+fIBcDgDqeptKPiDRSQvkXzPfLbdLvNHkvPrsEIZ0tvxKeqxRiLPOZeL0fxbe56vgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkdOLGx5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkdOLGx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713262273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jutTbcg1BhNDcoUSvv4lBJLotFFwn5kLxs7m05tKt+4=;
	b=VkdOLGx5z7QYE4NKXr9d/kIekIKHni/oF8guvO1QPjhea2IyYVCoIecUgKV0mqfFL32bFQ
	flKm5Ekx2ZyI6r36uhhzWHPFigo6VYSEwJH8UAHp/73fHsDnlBC9nEF+3OK4jWqKl4Z15b
	YQdt5qvk8re11BorIvZ8sJjy/E/R6WQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-FFJrStlHM3yqQXoNI7Yekg-1; Tue, 16 Apr 2024 06:11:11 -0400
X-MC-Unique: FFJrStlHM3yqQXoNI7Yekg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F136188ACA1
	for <gfs2@lists.linux.dev>; Tue, 16 Apr 2024 10:11:11 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0541140B497A;
	Tue, 16 Apr 2024 10:11:10 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/3] gfs2: do_xmote fixes
Date: Tue, 16 Apr 2024 12:10:47 +0200
Message-ID: <20240416101050.636697-1-agruenba@redhat.com>
In-Reply-To: <20240411135243.260020-1-agruenba@redhat.com>
References: <20240411135243.260020-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A closer review of commit 86934198eefa ("gfs2: Clear flags when withdraw
prevents xmote") has revealed that this commit got things very wrong and
that a more thorough cleanup of function do_xmote() is in order.  Here
is a set of three patches for doing that:

gfs2: finish_xmote cleanup

  Pushes more of the glock spin lock logic into do_xmote() which then
  allows to simplify things there.

gfs2: Fix do_xmote locking error

  The actual do_xmote() fixes and cleanup.

gfs2: Remove and replace gfs2_glock_queue_work

  A follow-up cleanup now that the previous patch has eliminated the last
  user of gfs2_glock_queue_work().

This obsoletes the previous patch "gfs2: Fix do_xmote locking error"
(https://lore.kernel.org/gfs2/20240411135243.260020-1-agruenba@redhat.com/).

Thanks,
Andreas

Andreas Gruenbacher (3):
  gfs2: finish_xmote cleanup
  gfs2: do_xmote fixes
  gfs2: Remove and replace gfs2_glock_queue_work

 fs/gfs2/glock.c | 78 ++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

-- 
2.44.0

