Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBC48780
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxgE8dN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703101144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNEid5UMrK9sc1Zaclm4GVQl+NkakOmK1imkHU7QXKg=;
	b=DxgE8dN19Wgyl0F6YhRZo00Pne1fiZ3FRGkR1OLAs4X2+KUcKgb3ttM+2jEki1yD+MyAKG
	C5xdI1zxB38cxj7v8lFDr6SkNdH4XDqxqfGZ24N7pVB2PeMH3cG/CNqafcrEW+mlNUk/Qd
	3iv49jsp7Z31c1a6bcwIOjAxwHRzNFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-z82FEyikMQ2bysId9_cKkA-1; Wed, 20 Dec 2023 14:39:02 -0500
X-MC-Unique: z82FEyikMQ2bysId9_cKkA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3466101A52A
	for <gfs2@lists.linux.dev>; Wed, 20 Dec 2023 19:39:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fast.eng.rdu2.dc.redhat.com [10.6.23.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A42A492BFA;
	Wed, 20 Dec 2023 19:39:02 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	aahringo@redhat.com
Subject: [PATCH dlm/next 2/2] dlm: update format header reflect current format
Date: Wed, 20 Dec 2023 14:38:59 -0500
Message-Id: <20231220193859.1333839-2-aahringo@redhat.com>
In-Reply-To: <20231220193859.1333839-1-aahringo@redhat.com>
References: <20231220193859.1333839-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Over the time the dlm debugfs format string has been changed but the
header wasn't updated. This patch changes the first line dump header and
their meaning to reflect the current formats.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 87ec499777c5..72bd72d07d66 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -443,14 +443,14 @@ static int table_seq_show(struct seq_file *seq, void *iter_ptr)
 		break;
 	case 3:
 		if (ri->header) {
-			seq_puts(seq, "version rsb 1.1 lvb 1.1 lkb 1.1\n");
+			seq_puts(seq, "rsb ptr nodeid first_lkid flags !root_list_empty !recover_list_empty recover_locks_count len\n");
 			ri->header = 0;
 		}
 		print_format3(ri->rsb, seq);
 		break;
 	case 4:
 		if (ri->header) {
-			seq_puts(seq, "version 4 rsb 2\n");
+			seq_puts(seq, "rsb ptr nodeid master_nodeid dir_nodeid our_nodeid toss_time flags len str|hex name\n");
 			ri->header = 0;
 		}
 		print_format4(ri->rsb, seq);
-- 
2.39.3

