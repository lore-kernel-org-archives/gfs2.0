Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911B1A3160
	for <gfs2@lists.linux.dev>; Sun, 14 Dec 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765678768; cv=none; b=aI/qCJseqLK/KTc+VmUF+S07E74PI58IJtoqGixPj9U5tlfPW7IePds73r9dSFQm3R8BZrbZfObZ1QPGWJqWsQS4GvbdRi4LOorerx0kYHu0WLSn12HqphXnIay6aFfyQOkBxVHezCIDdX+eksCwCRuz8EARis+Azpu5o10C7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765678768; c=relaxed/simple;
	bh=j3bIBt24tMIq9xbf/j9Eb31YD3fsFe5DR6H/p/WXd5I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=etrer2eyUG1LEilyCgOR8F1SjjalTYXrXuM5lxINBXvcA9YaLnQHIKrPzOqc4VbPfxAGX5g9qH1hx8hciTrmTkud5BKbey/ywk5ZOkBXD3ZVrgiQIg9nSoD+86jm0goNQjRXCknLSFW3ju2aNKnmy4SvO3j7sV3BHkZTNPhrNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h4kkgMvf; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h4kkgMvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765678752; bh=VGzst+VcBHvo0og59EZXIu2orh2UKPybJi+2gcsHtnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4kkgMvfOfkrOTjLABKFz0b04nB5wajPCPn7WEpOsztTB8qx7Adh4erXTaAKsFPhL
	 0LDdiKEDQntg2h36UcJzbX7c3bzsgbreg5/d7cSrDLSs6eBaTNdz3Ei4CMMI8W6aA4
	 Snl0dnwAooPY8snCF1PLiqYTTRW/hP+5ywbqG/WU=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 47401A92; Sun, 14 Dec 2025 10:17:52 +0800
X-QQ-mid: xmsmtpt1765678672t1muhc8ap
Message-ID: <tencent_B55495E8E88EEE66CC2C7A1E6FBC2FC16C0A@qq.com>
X-QQ-XMAILINFO: MSPab3JKqisNi9+6zP1RRebQEljojZuV0/b2+pyoKCPAQSq5A/KYOMe2KDM2PY
	 /DPDYU0HeNj5BEu9NG79aDm5ar+Buy0tWdjbU4gVBGrJEfSjJQNejL5dFfX3cRwo/hapfJ142Mtd
	 OzRmoW/WPo795XL9F7p4WLHroxDXWZusc3bvqRQIIDJmnoQAm01+RKMiCNWjgFJOph2dXNG23b/D
	 cTLXSDNCQaR9XQeswKy0AywGDs1KwpJVmPjmGAK+a5eu5fF06kezurrqhuh0Ucse2htZyMs/cid2
	 bXnqsys1OKBMgLOUcnjDc/+vWJvuZ+MG9oJmgi8vSEWHvgNH7XHzKFSYIvjjh0m5sHxo22jEbQ+N
	 ril7UAG9GWH4urwJWkJ6vZ84yCSptblO11v/jpyP6jV4lFnYUTYXG1sQPKLHQWWlaQuYQe57wPmB
	 PJCsgQxt3YGQXQ6BF1840DKDrKOLkq9qgBYk65NebXCrwsNoguSK+MzIIT0jaRhIhDZv/7uYr0cT
	 QGRs1+FY9H5SRPv2+pnnBjuHGezMKeXO5cj+rC7b3PORPkpF1eVaKXv7Vulgf+34jX79dFbVN86O
	 gcYRx8UWLUrxyCoOUEFy+MhdURrueUrVIfKa0OD/FHqTUeGgWQbA1qug3oNWPvt5YWkbtJfx3XWy
	 0kerTtX2PmhgyDs8oKjmcFDFM5226cUKSZbdXWu5pCTyrrvngJh5osQljm9ccbSax6Iy5CEFdfds
	 cDfy+fJLbwecDYFGGz7GFHjluSd0jCbeM3DELMsntZZjU75pmZbH4LPz9WaAXlLej2/MeF6xtdcr
	 Iu4jUx8Ey3mLwK7S8//aeoNhf/d+EUlV1ZL1+tdPuJQYiTS1S17zJ4VigB3hrWB9vIbrOSxnNlym
	 1hHJ/AadLvvMJaGdQphKY8J76guts7vgkmbHiUZ0Tk0Ze5ENonuWXtT3RufGtIHPkRwz0ZSV2WWf
	 4DYpCDnjyC2ytxdUPhG2/mxq1P76DMkBYglV0W0dK8ElXS/a/QRoXWnCzj3E1iFxEiOKE9622hAQ
	 ZH+hw7VM6Be07oi1hx
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: agruenba@redhat.com
Cc: eadavis@qq.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
Subject: Re: [PATCH Next] gfs2: update end and prev bio for chain bio
Date: Sun, 14 Dec 2025 10:17:51 +0800
X-OQ-MSGID: <20251214021751.60394-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHc6FU50_ZQM2G3y_z11J99xgRUE5yGj5DHKhpgEQd4QpmCLTg@mail.gmail.com>
References: <CAHc6FU50_ZQM2G3y_z11J99xgRUE5yGj5DHKhpgEQd4QpmCLTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Dec 2025 13:47:40 +0100, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Mon, Dec 8, 2025 at 7:12 AM Edward Adam Davis <eadavis@qq.com> wrote:
> > The bios are created and initialized using gfs2_log_alloc_bio() in
> > gfs2_find_jhead(), which sets bi_end_io and bi_private. When the I/O
> > request is too large and needs to be split into multiple bios and
> > submitted as a chain, the bug reported by syzbot [1] is triggered.
> >
> > When we need to submit multiple bios in a chain, we need to pass the
> > bi_end_io and bi_private of the previous bio to the end bio to ensure
> > that the multiple bios are correctly assembled into a submission chain.
> >
> > [1]
> > kernel BUG at block/bio.c:342!
> > Call Trace:
> >  gfs2_chain_bio fs/gfs2/lops.c:487 [inline]
> >  gfs2_find_jhead+0x627/0xe40 fs/gfs2/lops.c:549
> >  gfs2_recover_func+0x5f5/0x1c90 fs/gfs2/recovery.c:459
> >
> > Fixes: 8a157e0a0aa5 ("gfs2: Fix use of bio_chain")
> > Reported-by: syzbot+f6539d4ce3f775aee0cc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=f6539d4ce3f775aee0cc
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  fs/gfs2/lops.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > index 97ebe457c00a..2de334034c74 100644
> > --- a/fs/gfs2/lops.c
> > +++ b/fs/gfs2/lops.c
> > @@ -484,6 +484,10 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
> >         new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
> >         bio_clone_blkg_association(new, prev);
> >         new->bi_iter.bi_sector = bio_end_sector(prev);
> > +       new->bi_end_io = prev->bi_end_io;
> > +       new->bi_private = prev->bi_private;
> > +       prev->bi_end_io = NULL;
> > +       prev->bi_private = NULL;
> >         bio_chain(prev, new);
> >         submit_bio(prev);
> >         return new;
> > --
> > 2.43.0
> >
> 
> thanks for this patch, it looks correct. However, the underlying
> problem is that bi_end_io and bi_private are set too early, and if we
> change the code to set those fields before submitting the bio, we
> won't need this hack in gfs2_chain_bio().
> 
> I have pushed patches doing that onto for-next:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next
> 
> Does this work for you?
I think it's work for me.

BR,
Edward

